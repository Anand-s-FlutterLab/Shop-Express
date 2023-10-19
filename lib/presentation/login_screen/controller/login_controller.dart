import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/login_screen/model/login_model.dart';
import 'package:shopexpress/core/Utils/common_utils.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoginPressed = false.obs;
  RxBool obscureText = true.obs;

  Future<void> onLogin() async {
    isLoginPressed.value = true;
    if (loginFormKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((userCredential) {
          getUserData(userCredential.user!.uid);
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

  Future<void> getUserData(String userId) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        LoginModel loginModel = LoginModel.fromJson(data);
        userID.value = FirebaseAuth.instance.currentUser!.uid;
        isAdmin.value = loginModel.isAdmin;
        userName.value = loginModel.firstName;
        await writeStorage(storageUserID, userId);
        await writeStorage(storageUserFirstName, loginModel.firstName);
        await writeStorage(storageUserRole, isAdmin.value ? "Admin" : "User");
        isLoginPressed.value = false;
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Get.offNamed(AppRoutes.homeScreen);
        } else {
          Get.offNamed(AppRoutes.emailVerificationScreen);
        }
      } else {
        isLoginPressed.value = false;
        customSnackBar(
            "Username Not Found",
            "Apologies, but the username you entered could not be located in our system.",
            "red");
      }
    } catch (error) {
      print(error);
      isLoginPressed.value = false;
      handleFirebaseError(error);
    }
  }
}
