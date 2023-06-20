import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/Utils/common_utils.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/profile_screen/model/profile_model.dart';

class ProfileController extends GetxController {
  RxList<ProfileModel> profileModel = <ProfileModel>[].obs;
  RxBool isLoading = false.obs;
  RxString profileURL = "".obs;

  @override
  void onInit() async {
    await getProfileData();
    await getProfileUrl();
    super.onInit();
  }

  Future<void> getProfileUrl() async {
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection(collectionUsers)
        .doc(userID.value);

    DocumentSnapshot snapshot = await documentRef.get();

    if (snapshot.exists) {
      profileURL.value = snapshot.get('Profile URL');
    } else {
      print('Document does not exist');
    }
  }

  Future<void> getProfileData() async {
    isLoading.value = true;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionProfileImages)
        .orderBy(FieldPath.documentId)
        .get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      ProfileModel profileData = ProfileModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
      profileModel.add(profileData);
    }
    isLoading.value = false;
  }

  Future<void> onLogout() async {
    try {
      FirebaseAuth.instance.signOut();
      selectedBottomNavigationIndex = 0;
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (error) {
      handleFirebaseError(error);
    }
  }

  void routesHandler(String route) {
    switch (route) {
      case 'Edit Profile':
        Get.toNamed(AppRoutes.editProfileScreen);
        break;
      case 'Orders':
        Get.toNamed(AppRoutes.ordersScreen);
        break;
      case 'Saved Addresses':
        Get.toNamed(AppRoutes.savedAddressesScreen);
        break;
      case 'Saved Cards':
        Get.toNamed(AppRoutes.savedCardsScreen);
        break;
      case 'Wallet':
        Get.toNamed(AppRoutes.savedAddressesScreen);
        break;
      case 'Customer Support':
        Get.toNamed(AppRoutes.customerSupportScreen);
        break;
    }
  }
}
