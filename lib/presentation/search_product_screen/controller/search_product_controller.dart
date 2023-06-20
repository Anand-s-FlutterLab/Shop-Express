import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/search_product_screen/model/search_product_model.dart';
import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';
import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';

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
      if (!isSpecialOfferSelected.value && customSearch.value == "") {
        isSpecialOfferSelected.value = false;
        int start = categoryRanges[selectedCategory.value]!.elementAt(0);
        int end = categoryRanges[selectedCategory.value]!.elementAt(1);
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
      } else if (customSearch.value == " " || customSearch.value.isEmpty) {
        isSpecialOfferSelected.value = false;
        int start = categoryRanges["All Products"]?.elementAt(0) ?? 0;
        int end = categoryRanges["All Products"]?.elementAt(1) ?? 0;
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

  void toggleFavorite(int index) async {
    products[index].isFavorite.value = !products[index].isFavorite.value;

    await updateFavoriteStatus(
        products[index].productId, products[index].isFavorite.value);
  }

  Future<void> updateFavoriteStatus(String productId, bool isFavorite) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({'isFavorite': isFavorite});
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  void addToCartFromSearchProduct(int index) {
    final cartItem = CartItem(
      productId: products[index].productId,
      productName: products[index].productName,
      productBrand: products[index].productBrand,
      productDisplayPrice: products[index].productDisplayPrice,
      productQuantity: 1.obs,
      displayImageLink: products[index].displayImageLink,
    );

    final cartController = Get.find<CartController>();
    cartController.addItemToCart(cartItem);
  }
}
