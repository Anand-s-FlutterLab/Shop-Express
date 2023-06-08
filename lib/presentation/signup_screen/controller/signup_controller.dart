import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/Network/firebase_error_handler.dart';
import 'package:shopexpress/routes/app_routes.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Timer _timer;
  RxBool isSignupPressed = false.obs;

  Future<void> onSignup() async {
    isSignupPressed.value = true;
    if (signupFormKey.currentState!.validate()) {
      {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((userCredential) {
          isSignupPressed.value = false;
          Get.offNamed(AppRoutes.emailVerificationScreen);
          return userCredential;
        }).catchError(
          (error) {
            isSignupPressed.value = false;
            handleFirebaseError(error);
            return Future.error(error);
          },
        );
      }
    } else {
      isSignupPressed.value = false;
      print("Failed");
    }
  }
}
