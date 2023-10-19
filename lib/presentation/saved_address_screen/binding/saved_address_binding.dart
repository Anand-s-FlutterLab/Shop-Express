import 'package:get/get.dart';
import 'package:shopexpress/presentation/saved_address_screen/controller/saved_address_controller.dart';

class SavedAddressesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedAddressesController());
  }
}
