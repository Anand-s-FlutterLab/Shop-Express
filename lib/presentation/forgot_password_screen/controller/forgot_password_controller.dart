import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/app_export.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController forgotPasswordController = TextEditingController();
  RxBool isGetLinkPressed = false.obs;
  RxBool isLinkGenerated = false.obs;

  Future<void> forgotPasswordLinkGenerator() async {
    isGetLinkPressed.value = true;
    if (forgotPasswordFormKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: forgotPasswordController.text)
            .then((value) {
          isLinkGenerated.value = true;
          isGetLinkPressed.value = false;
          return true;
        }).catchError((onError) {
          isGetLinkPressed.value = false;
          handleFirebaseError(onError);
          return Future.error(onError);
        });
      } catch (error) {
        isGetLinkPressed.value = false;
        handleFirebaseError(error);
        print(error);
        return Future.error(error);
      }
    }
    else{
      isGetLinkPressed.value = true;
    }
  }
}
