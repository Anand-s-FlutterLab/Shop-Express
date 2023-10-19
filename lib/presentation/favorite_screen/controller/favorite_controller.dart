import 'package:flutter/scheduler.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/favorite_screen/model/favorite_model.dart';
import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';
import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';

class FavoriteController extends GetxController implements TickerProvider {

  RxBool isLoading = false.obs;
  RxList<FavoriteModel> favoriteModel = <FavoriteModel>[].obs;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animationController.forward();
    getFavoriteProducts();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  Future<void> getFavoriteProducts() async {
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('products')
        .where("isFavorite", isEqualTo: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      favoriteModel.clear();
      for (DocumentSnapshot documentSnapshot in snapshot.docs) {
        FavoriteModel product = FavoriteModel(
          productName: documentSnapshot['productName'],
          productBrand: documentSnapshot['productBrand'],
          productId: documentSnapshot['productId'],
          productPrice: documentSnapshot['productPrice'],
          productDiscount: documentSnapshot['productDiscount'],
          productDisplayPrice: documentSnapshot['productDisplayPrice'],
          displayImageLink: documentSnapshot['displayImageLink'],
        );
        favoriteModel.add(product);
        favoriteModel.refresh();
      }
    });
    isLoading.value = false;
  }

  Future<void> updateFavoriteStatus(int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(favoriteModel[index].productId)
          .update({'isFavorite': false});
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  void addToCartFromFavorite(int index) {
    final cartItem = CartItem(
      productId: favoriteModel[index].productId,
      productName: favoriteModel[index].productName,
      productBrand: favoriteModel[index].productBrand,
      productDisplayPrice: favoriteModel[index].productDisplayPrice,
      productQuantity: 1.obs,
      displayImageLink: favoriteModel[index].displayImageLink,
    );

    final cartController = Get.find<CartController>();
    cartController.addItemToCart(cartItem);
  }
}
