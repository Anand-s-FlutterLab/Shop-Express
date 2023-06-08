import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/routes/app_routes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoginPressed = false.obs;

  Future<void> onLogin() async {
    isLoginPressed.value = true;
    if (loginFormKey.currentState!.validate()) {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((value) {
          isLoginPressed.value = false;
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Get.offNamed(AppRoutes.homeScreen);
          } else {
            Get.offNamed(AppRoutes.emailVerificationScreen);
          }
        });
      } catch (error) {
        isLoginPressed.value = false;
        handleFirebaseError(error);
        return Future.error(error);
      }
    } else {
      isLoginPressed.value = false;
      print("Failed");
    }
  }
}
