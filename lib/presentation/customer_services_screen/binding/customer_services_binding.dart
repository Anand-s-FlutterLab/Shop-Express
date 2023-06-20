import 'package:get/get.dart';
import 'package:shopexpress/presentation/customer_services_screen/controller/customer_services_controller.dart';

class CustomerSupportBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerSupportController());
  }
}
