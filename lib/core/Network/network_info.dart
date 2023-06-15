import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/app_export.dart';

class ConnectivityController extends GetxController {
  RxBool hasInternet = true.obs;
  RxBool shownErrorScreenBefore = false.obs;

  @override
  void onInit() {
    super.onInit();
    startListening();
  }

  void startListening() {
    Connectivity().onConnectivityChanged.listen((connectivityResult) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      hasInternet.value = (connectivityResult != ConnectivityResult.none);
      hasInternet.refresh();
      print("Internet Connected: ${hasInternet.value}");
      if (!hasInternet.value) {
        Get.offNamed(AppRoutes.errorScreen);
        shownErrorScreenBefore.value = true;
      } else {
        if (FirebaseAuth.instance.currentUser != null) {
          if (Get.overlayContext != null) {
            Navigator.of(Get.overlayContext!).canPop()
                ? Get.back()
                : Get.offNamed(AppRoutes.homeScreen);
          } else {
            Get.offNamed(AppRoutes.homeScreen);
          }
        } else if (shownErrorScreenBefore.value) {
          Get.offNamed(AppRoutes.loginScreen);
        }
      }
    });
  }
}
