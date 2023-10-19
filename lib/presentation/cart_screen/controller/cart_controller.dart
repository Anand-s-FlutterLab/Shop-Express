import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';

import '../../../widgets/gif_animator.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxDouble subTotal = 0.0.obs;
  RxDouble shippingCharges = 0.0.obs;
  RxDouble taxes = 0.0.obs;
  RxDouble orderTotal = 0.0.obs;

  void addItemToCart(CartItem item) {
    if (cartItems.isNotEmpty) {
      bool itemMatched = false;
      for (var i = 0; i < cartItems.length; i++) {
        if (cartItems[i].productId == item.productId) {
          itemMatched = true;
        }
      }
      if (!itemMatched) {
        Get.dialog(GifAnimator(
          imagePath: addToCart,
          duration: Duration(milliseconds: 2700),
          frames: 90,
        ));
        cartItems.add(item);
        updateCartNumber();
        updateCartTotal();
      } else {
        customSnackBar("Alert", "Item already in cart", 'red');
      }
    } else {
      Get.dialog(GifAnimator(
        imagePath: addToCart,
        duration: Duration(milliseconds: 2700),
        frames: 90,
      ));
      cartItems.add(item);
      updateCartNumber();
      updateCartTotal();
    }
  }

  void removeItemFromCart(int index) {
    cartItems.removeAt(index);
    Get.dialog(GifAnimator(
      imagePath: deleteGIF,
      duration: Duration(milliseconds: 3660),
      frames: 122,
    ));
    updateCartNumber();
    updateCartTotal();
  }

  void updateCartNumber() {
    cartItemNumber.value = cartItems.length;
  }

  void updateProductFinalPrice(int index) {
    cartItems[index].productFinalPrice.value =
        (cartItems[index].productDisplayPrice *
            cartItems[index].productQuantity.value);
  }

  void updateCartTotal() {
    subTotal.value = 0;
    for (var i = 0; i < cartItems.length; i++) {
      updateProductFinalPrice(i);
      subTotal.value += cartItems[i].productFinalPrice.value;
    }
    if (subTotal < 10000.0) {
      shippingCharges.value = 50;
    } else {
      shippingCharges.value = 0;
    }
    taxes.value = subTotal.value * 0.01;
    orderTotal.value =
        (subTotal.value + shippingCharges.value + taxes.value).roundToDouble();
  }
}
