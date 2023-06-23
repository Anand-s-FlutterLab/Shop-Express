import 'package:shopexpress/core/app_export.dart';

import '../model/saved_cards_model.dart';

class SavedCardsController extends GetxController {
  final GlobalKey<FormState> savedCardsFormKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  RxBool isUploadPressed = false.obs;
  RxBool isLoading = false.obs;
  RxList<CreditCardDetails> creditCardDetails = <CreditCardDetails>[].obs;

  @override
  void onInit() {
    getCard();
    super.onInit();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void formatNumber() {
    final String value =
        cardNumberController.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final regex = RegExp(r'.{1,4}');
    final formattedText =
        value.replaceAllMapped(regex, (match) => '${match.group(0)} ');
    cardNumberController.value = TextEditingValue(
      text: formattedText.trim(),
      selection: TextSelection.collapsed(offset: formattedText.length - 1),
    );
  }

  Future<void> addCard() async {
    isUploadPressed.value = true;
    CreditCardDetails addCreditCardDetails = CreditCardDetails(
      cardNumber: cardNumberController.text,
      expiryDate: expiryDateController.text,
      cvv: cvvController.text,
      name: nameController.text,
    );
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);
      await docRef.set({
        'Saved Cards': FieldValue.arrayUnion([addCreditCardDetails.toJson()])
      }, SetOptions(merge: true));
      getCard();
      Get.back();
      customSnackBar("Success", "Card has been successfully Added", 'green');
    } catch (error) {
      handleFirebaseError(error);
    } finally {
      isUploadPressed.value = false;
    }
  }

  Future<void> getCard() async {
    isLoading.value = true;
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);
      await docRef.get().then((value) {
        List savedAddressSnapshot = value.get('Saved Cards') ?? [];
        creditCardDetails.clear();
        if (savedAddressSnapshot.isNotEmpty) {
          for (var i = 0; i < savedAddressSnapshot.length; i++) {
            CreditCardDetails address =
                CreditCardDetails.fromJson(savedAddressSnapshot[i]);
            creditCardDetails.add(address);
          }
        }
      });
    } catch (error) {
      if (error is! StateError) {
        handleFirebaseError(error);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
