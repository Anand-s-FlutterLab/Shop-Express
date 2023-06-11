import 'package:get/get.dart';
import 'package:shopexpress/presentation/profile_screen/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
