import 'package:get/get.dart';
import 'package:shopexpress/presentation/product_details_screen/controller/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
