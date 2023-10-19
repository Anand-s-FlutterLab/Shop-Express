import 'package:get/get.dart';
import 'package:shopexpress/presentation/manage_item_slider_screen/controller/manage_item_slider_controller.dart';

class ManageItemSliderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageItemSliderController());
  }
}
