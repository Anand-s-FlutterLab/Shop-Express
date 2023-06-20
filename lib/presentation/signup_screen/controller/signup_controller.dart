import 'dart:async';
import 'package:shopexpress/core/Utils/common_utils.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/presentation/signup_screen/model/signup_model.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isSignupPressed = false.obs;
  RxBool obscureText = true.obs;

  Future<void> onSignup() async {
    isSignupPressed.value = true;
    if (signupFormKey.currentState!.validate()) {
      {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((userCredential) {
          userID.value = userCredential.user!.uid;
          userID.refresh();
          writeStorage(storageUserID, userID.value);
          addNewUser();
          Get.offNamed(AppRoutes.emailVerificationScreen);
          return userCredential;
        }).catchError(
          (error) {
            handleFirebaseError(error);
            return Future.error(error);
          },
        );
      }
    } else {
      isSignupPressed.value = false;
    }
  }

  Future<void> addNewUser() async {
    try {
      SignUpModel signUpData = SignUpModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        emailAddress: emailController.text,
      );
      userName.value = firstNameController.text;
      await writeStorage(storageUserFirstName, firstNameController.text);
      final DocumentReference productDoc = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);
      await productDoc.set(signUpData.toJson()).then((value) {
        isSignupPressed.value = false;
      }).catchError((error) {
        handleFirebaseError(error);
      });
    } catch (error) {
      handleFirebaseError(error);
    }
  }
}
