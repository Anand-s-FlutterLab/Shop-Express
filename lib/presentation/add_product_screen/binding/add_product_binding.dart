import 'package:get/get.dart';
import 'package:shopexpress/presentation/add_product_screen/controller/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}
