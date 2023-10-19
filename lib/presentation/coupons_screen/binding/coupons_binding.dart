import 'package:get/get.dart';
import 'package:shopexpress/presentation/coupons_screen/controller/coupons_controller.dart';

class CouponsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CouponsController());
  }
}
