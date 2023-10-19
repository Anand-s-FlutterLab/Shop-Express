import 'package:get/get.dart';
import 'package:shopexpress/presentation/checkout_screen/controller/checkout_controller.dart';
import 'package:shopexpress/presentation/saved_address_screen/controller/saved_address_controller.dart';
import 'package:shopexpress/presentation/saved_cards_screen/controller/saved_cards_controller.dart';

class CheckoutBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController());
    Get.lazyPut(() => SavedAddressesController());
    Get.lazyPut(() => SavedCardsController());
  }
}
