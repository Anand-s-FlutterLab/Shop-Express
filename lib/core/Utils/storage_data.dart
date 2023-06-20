import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/app_export.dart';
import 'common_utils.dart';

class InitialDataLoad extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await initializeApp();
  }

  Future<void> initializeApp() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String role = await readStorage(storageUserRole) ?? "";
      isAdmin.value = role == "Admin";
      userID.value = FirebaseAuth.instance.currentUser!.uid;
      userName.value = await readStorage(storageUserFirstName) ?? "";

      if (userID.isEmpty || userName.isEmpty) {
        customSnackBar(
          "Session Expire",
          "Your session has expired. Please proceed to log in again to continue.",
        );
        Get.offNamed(AppRoutes.loginScreen);
      } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offNamed(AppRoutes.homeScreen);
      } else {
        Get.offNamed(AppRoutes.emailVerificationScreen);
      }
    } else {
      Get.offNamed(AppRoutes.loginScreen);
    }
  }
}
