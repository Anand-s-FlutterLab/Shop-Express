import 'package:get/get.dart';
import 'package:shopexpress/presentation/manage_account_screen/controller/manage_account_controller.dart';

class ManageAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageAccountController());
  }
}
