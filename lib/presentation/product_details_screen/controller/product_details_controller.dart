import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/product_details_screen/model/product_details_model.dart';

import '../../cart_screen/controller/cart_controller.dart';
import '../../cart_screen/model/cart_model.dart';

class ProductDetailsController extends GetxController {
  TextEditingController quantityController = TextEditingController();
  RxInt currentQuantity = 1.obs;
  RxBool isDataFetched = false.obs;
  late ProductDetailsModel product;
  RxDouble currentPage = 0.0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    getFireStoreData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> getFireStoreData() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('products')
        .doc(globalProductID.value)
        .get();

    product = ProductDetailsModel.fromFirestore(
        document.data() as Map<String, dynamic>);
    currentPage.value = product.productImages.length.toDouble();
    pageController = PageController(initialPage: product.productImages.length);
    pageController.addListener(() {
      currentPage.value = pageController.page!;
    });
    isDataFetched.value = true;
    isDataFetched.refresh();
  }

  void toggleFavorite() async {
    product.isFavorite.value = !product.isFavorite.value;

    await updateFavoriteStatus(
        product.productId, product.isFavorite.value);
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

  void addToCartFromProductDetails() {
    final cartItem = CartItem(
      productId: product.productId,
      productName: product.productName,
      productBrand: product.productBrand,
      productDisplayPrice: product.productDisplayPrice,
      productQuantity: currentQuantity,
      displayImageLink: product.displayImageLink,
    );

    final cartController = Get.find<CartController>();
    cartController.addItemToCart(cartItem);
  }
}
