import 'package:get/get.dart';
import 'package:shopexpress/presentation/manage_product_screen/controller/manage_product_controller.dart';

class ManageProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ManageProductController());
  }

}