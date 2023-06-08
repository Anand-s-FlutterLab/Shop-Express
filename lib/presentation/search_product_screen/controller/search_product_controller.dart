import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/search_product_screen/model/search_product_model.dart';

class SearchProductController extends GetxController {
  int limit = 10;
  RxBool isLoading = false.obs;
  RxList<SearchProductModel> products = <SearchProductModel>[].obs;

  void onInit(){
    super.onInit();
    getProductItems();
  }

  Future<void> getProductItems() async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('products').get();

      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        SearchProductModel product =
        SearchProductModel.fromFirestore(documentSnapshot.data() as Map<String, dynamic>);
        products.add(product);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error retrieving product items: $e');
    }
  }
}
