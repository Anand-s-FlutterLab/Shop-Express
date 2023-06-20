import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';
import 'package:shopexpress/presentation/saved_address_screen/controller/saved_address_controller.dart';
import 'package:shopexpress/presentation/saved_cards_screen/controller/saved_cards_controller.dart';
import 'package:shopexpress/presentation/checkout_screen/model/checkout_model.dart';

import '../../../widgets/gif_animator.dart';

class CheckoutController extends GetxController {
  final cartController = Get.find<CartController>();
  final savedAddressesController = Get.find<SavedAddressesController>();
  final savedCardsController = Get.find<SavedCardsController>();

  RxBool isLoading = false.obs;
  RxInt selectedAddressIndex = 0.obs;
  RxString selectedPaymentMethod = "".obs;
  RxList<CheckoutImages> checkoutImages = <CheckoutImages>[].obs;

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

  Future<void> gatherAllData() async {
    isLoading.value = true;
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
      print(documentSnapshot.data());
      CheckoutImages profileData = CheckoutImages.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
      checkoutImages.add(profileData);
    }
  }

  Future<void> uploadOrderToFirebase() async {
    Get.dialog(GifAnimator(
      imagePath: orderPlacedGIF,
      duration: Duration(milliseconds: 5200),
      frames: 351,
    )).then((value) {
      cartController.cartItems.clear();
      Get.offNamed(AppRoutes.homeScreen);
    });
    CheckoutModel checkoutModel = CheckoutModel(
      totalItems: cartController.cartItems.length,
      subTotal: cartController.subTotal.value,
      shippingCharges: cartController.shippingCharges.value,
      taxes: cartController.taxes.value,
      paymentMethod: selectedPaymentMethod.value,
      expectedDeliveryDate: DateTime.now().add(Duration(days: 5)),
      orderStatus: "Placed",
      items: cartController.cartItems,
      deliveryAddress: savedAddressesController
          .savedDeliveryAddress[selectedAddressIndex.value]!,
    );
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);

      await docRef.set({
        'Orders': FieldValue.arrayUnion([checkoutModel.toJson()])
      }, SetOptions(merge: true));
      selectedAddressIndex.value = 0;
      selectedPaymentMethod.value = "";
      checkoutImages.clear();
    } catch (error) {
      handleFirebaseError(error);
    }
  }
}
