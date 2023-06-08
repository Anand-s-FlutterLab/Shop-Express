import 'package:get/get.dart';
import 'package:shopexpress/presentation/login_screen/controller/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}