import 'package:get/get.dart';
import 'package:shopexpress/presentation/orders_screen/controller/orders_controller.dart';

class OrdersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}
