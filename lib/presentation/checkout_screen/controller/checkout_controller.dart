import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';
import 'package:shopexpress/presentation/saved_address_screen/controller/saved_address_controller.dart';
import 'package:shopexpress/presentation/saved_cards_screen/controller/saved_cards_controller.dart';
import 'package:shopexpress/presentation/checkout_screen/model/checkout_model.dart';
import 'package:shopexpress/widgets/gif_animator.dart';
import 'package:shopexpress/presentation/coupons_screen/model/coupons_model.dart';

class CheckoutController extends GetxController {
  final GlobalKey<FormState> couponFormKey = GlobalKey<FormState>();
  final cartController = Get.find<CartController>();
  final savedAddressesController = Get.find<SavedAddressesController>();
  final savedCardsController = Get.find<SavedCardsController>();

  TextEditingController couponController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool couponsLoading = true.obs;
  RxInt selectedAddressIndex = 0.obs;
  RxString selectedPaymentMethod = "".obs;
  RxList<CheckoutImages> checkoutImages = <CheckoutImages>[].obs;
  late Coupons coupons;
  RxDouble finalCheckoutPrice = 0.0.obs;
  RxString appliedCouponName = "".obs;
  RxInt appliedCouponDiscount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    gatherAllData().then((value) {
      if (savedAddressesController.savedDeliveryAddress.isEmpty) {
        isLoading.value = false;
        Get.toNamed(AppRoutes.savedAddressesScreen);
        customSnackBar("Incomplete Details", "Delivery Address not found");
      }
      isLoading.value = false;
    });
  }

  void validateCoupon() async {
    appliedCouponName.value = "";
    appliedCouponDiscount.value = 0;
    finalCheckoutPrice.value = cartController.orderTotal.value;
    await getCoupons().then((value) {
      if (value) {
        if (cartController.subTotal <= coupons.minimumOrderAmount) {
          customSnackBar("Coupon not applied",
              "Minimum sub total should be ${coupons.minimumOrderAmount}");
        } else {
          appliedCouponName.value = coupons.couponName;
          appliedCouponDiscount.value = coupons.couponDiscountPercentage;
          finalCheckoutPrice.value = (cartController.subTotal.value -
                  (cartController.subTotal.value *
                      (appliedCouponDiscount.value / 100)) +
                  cartController.taxes.value +
                  cartController.shippingCharges.value)
              .roundToDouble();
        }
      } else {
        customSnackBar(
            "Invalid Coupon", "Please enter correct coupon to avail discount");
      }
    });
  }

  Future<void> gatherAllData() async {
    isLoading.value = true;
    finalCheckoutPrice.value = cartController.orderTotal.value;
    await savedAddressesController.savedAddresses();
    await savedCardsController.getCard();
    await getCheckoutImages();
  }

  Future<void> getCheckoutImages() async {
    checkoutImages.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionCheckoutImages)
        .orderBy(FieldPath.documentId)
        .get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      CheckoutImages profileData = CheckoutImages.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
      checkoutImages.add(profileData);
    }
  }

  Future<bool> getCoupons() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection(collectionCoupons)
          .doc(couponController.text)
          .get();
      print(document.data());
      if (document.data() == null) {
        return false;
      }
      coupons = Coupons.fromJson(document.data() as Map<String, dynamic>);
      return true;
    } catch (error) {
      print(error);
      if (error is! StateError) {
        handleFirebaseError(error);
      }
      return false;
    } finally {
      couponsLoading.value = false;
    }
  }

  Future<void> uploadOrderToFirebase() async {
    Get.dialog(GifAnimator(
      imagePath: orderPlacedGIF,
      duration: Duration(milliseconds: 5200),
      frames: 351,
    )).then((value) {
      selectedAddressIndex.value = 0;
      selectedPaymentMethod.value = "";
      checkoutImages.clear();
      cartController.cartItems.clear();
      cartItemNumber.value = 0;
      selectedBottomNavigationIndex = 0;
      Get.offNamed(AppRoutes.homeScreen);
    });
    CheckoutModel checkoutModel = CheckoutModel(
      totalItems: cartController.cartItems.length,
      subTotal: cartController.subTotal.value,
      shippingCharges: cartController.shippingCharges.value,
      taxes: cartController.taxes.value,
      paymentMethod: selectedPaymentMethod.value,
      orderStatus: "Placed",
      items: cartController.cartItems,
      deliveryAddress: savedAddressesController
          .savedDeliveryAddress[selectedAddressIndex.value]!,
      orderTotal: finalCheckoutPrice.value,
      appliedCoupon: couponController.text,
    );
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);

      await docRef.set({
        'Orders': FieldValue.arrayUnion([checkoutModel.toJson()])
      }, SetOptions(merge: true));
    } catch (error) {
      handleFirebaseError(error);
    }
  }
}
