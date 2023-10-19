import 'package:get/get.dart';
import 'package:shopexpress/presentation/edit_profile_screen/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
