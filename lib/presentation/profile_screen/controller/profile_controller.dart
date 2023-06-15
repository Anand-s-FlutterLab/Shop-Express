import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/Utils/common_utils.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/profile_screen/model/profile_model.dart';

class ProfileController extends GetxController {
  RxList<ProfileModel> profileModel = <ProfileModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getProfileData();
    super.onInit();
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
      Get.offNamed(AppRoutes.loginScreen);
    } catch (error) {
      handleFirebaseError(error);
    }
  }
}
