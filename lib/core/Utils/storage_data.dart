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
    String role = await readStorage(storageUserRole) ?? "";
    isAdmin.value = role == "Admin";
    userID.value = FirebaseAuth.instance.currentUser!.uid;
    userName.value = await readStorage(storageUserFirstName) ?? "";
  }
}
