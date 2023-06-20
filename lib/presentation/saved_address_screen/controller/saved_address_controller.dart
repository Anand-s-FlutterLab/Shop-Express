import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/saved_address_screen/model/saved_address_model.dart';

class SavedAddressesController extends GetxController {
  final GlobalKey<FormState> savedAddressFormKey = GlobalKey<FormState>();
  RxList<SavedAddress?> savedDeliveryAddress = <SavedAddress?>[].obs;
  RxBool isLoading = false.obs;
  RxBool isUploadPressed = false.obs;
  RxBool updateData = true.obs;
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController addressType = TextEditingController();
  TextEditingController mobile = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    savedAddresses();
  }

  Future<void> savedAddresses() async {
    isLoading.value = true;
    updateData.value = false;
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);
      await docRef.get().then((value) {
        List savedAddressSnapshot = value.get('Saved Addresses') ?? [];
        savedDeliveryAddress.clear();
        if (savedAddressSnapshot.isNotEmpty) {
          for (var i = 0; i < savedAddressSnapshot.length; i++) {
            SavedAddress address =
                SavedAddress.fromJson(savedAddressSnapshot[i]);
            savedDeliveryAddress.add(address);
          }
        }
      });
    } catch (error) {
      handleFirebaseError(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadDeliveryAddress() async {
    isUploadPressed.value = true;
    SavedAddress address = SavedAddress(
      addressLine1: addressLine1.text,
      addressLine2: addressLine2.text,
      city: city.text,
      state: state.text,
      country: country.text,
      postalCode: zipCode.text,
      addressType: addressType.text,
      mobile: mobile.text,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);

      await docRef.set({
        'Saved Addresses': FieldValue.arrayUnion([address.toJson()])
      }, SetOptions(merge: true));
      savedAddresses();
      Get.back();
      customSnackBar("Success", "Address has been successfully Added", 'green');
    } catch (error) {
      handleFirebaseError(error);
    } finally {
      isUploadPressed.value = false;
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        final List<dynamic> savedAddressSnapshot =
            snapshot.get('Saved Addresses') ?? [];

        final updatedAddresses = savedAddressSnapshot
            .where((address) => address['id'] != addressId)
            .toList();

        transaction.update(docRef, {'Saved Addresses': updatedAddresses});
      }).then((value) {
        Get.back();
        savedAddresses();
      });
    } catch (error) {
      handleFirebaseError(error);
    }
  }

  void setEditData(int index) {
    addressLine1.text = savedDeliveryAddress[index]!.addressLine1;
    addressLine2.text = savedDeliveryAddress[index]!.addressLine2;
    city.text = savedDeliveryAddress[index]!.city;
    state.text = savedDeliveryAddress[index]!.state;
    country.text = savedDeliveryAddress[index]!.country;
    zipCode.text = savedDeliveryAddress[index]!.postalCode;
    addressType.text = savedDeliveryAddress[index]!.addressType;
    mobile.text = savedDeliveryAddress[index]!.mobile;
  }

  Future<void> updateAddress(String addressId) async {
    SavedAddress updatedAddress = SavedAddress(
      addressLine1: addressLine1.text,
      addressLine2: addressLine2.text,
      city: city.text,
      state: state.text,
      country: country.text,
      postalCode: zipCode.text,
      addressType: addressType.text,
      mobile: mobile.text,
      id: addressId,
    );
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        final List<dynamic> savedAddressSnapshot =
            snapshot.get('Saved Addresses') ?? [];

        final updatedAddresses = savedAddressSnapshot.map((address) {
          if (address['id'] == addressId) {
            return updatedAddress.toJson();
          } else {
            return address;
          }
        }).toList();

        transaction.update(docRef, {'Saved Addresses': updatedAddresses});
      }).then((value) {
        Get.back();
        savedAddresses();
      });
    } catch (error) {
      handleFirebaseError(error);
    }
  }
}
