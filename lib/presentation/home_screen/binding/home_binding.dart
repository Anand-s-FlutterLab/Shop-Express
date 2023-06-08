import 'package:get/get.dart';
import 'package:shopexpress/presentation/home_screen/controller/home_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
