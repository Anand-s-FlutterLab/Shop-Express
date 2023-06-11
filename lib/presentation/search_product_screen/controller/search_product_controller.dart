import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/search_product_screen/model/search_product_model.dart';

class SearchProductController extends GetxController {
  int limit = 10;
  RxBool isLoading = false.obs;
  RxList<SearchProductModel> products = <SearchProductModel>[].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.text = customSearch.value;
    getProductItems();
  }

  Future<void> getProductItems() async {
    isLoading.value = true;
    try {
      products.clear();
      int start = categoryRanges[selectedCategory.value]?.elementAt(0) ?? 0;
      int end = categoryRanges[selectedCategory.value]?.elementAt(1) ?? 0;
      if (!isSpecialOfferSelected.value && customSearch.value == "") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where("productId", isGreaterThanOrEqualTo: start.toString())
            .where("productId", isLessThanOrEqualTo: end.toString())
            .get();

        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          SearchProductModel product = SearchProductModel.fromFirestore(
              documentSnapshot.data() as Map<String, dynamic>);
          products.add(product);
        }
      } else if (!isSpecialOfferSelected.value && customSearch.value != "") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where("productName", isGreaterThanOrEqualTo: customSearch.value)
            .where("productName",
                isLessThanOrEqualTo: "${customSearch.value}\uf8ff")
            .get();
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          SearchProductModel product = SearchProductModel.fromFirestore(
              documentSnapshot.data() as Map<String, dynamic>);
          products.add(product);
        }
      } else {
        isSpecialOfferSelected.value = false;
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('products')
            .orderBy('productDiscount', descending: true)
            .get();

        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          SearchProductModel product = SearchProductModel.fromFirestore(
              documentSnapshot.data() as Map<String, dynamic>);
          products.add(product);
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error retrieving product items: $e');
    }
  }
}
