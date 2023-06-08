import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:shopexpress/routes/app_routes.dart';

class EmailVerificationController extends GetxController {
  late Timer _timer;

  @override
  void onInit() {
    emailVerificationGenerator();
    super.onInit();
  }

  void emailVerificationGenerator() async {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      checkEmailVerificationStatus();
    });
  }

  void checkEmailVerificationStatus() async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      print('Email is verified');
      stopEmailVerificationCheck();
      Get.offNamed(AppRoutes.homeScreen);
    } else {
      print('Email is not verified');
    }
  }

  void stopEmailVerificationCheck() {
    _timer.cancel();
  }
}
