import 'package:get/get.dart';
import 'package:shopexpress/presentation/saved_cards_screen/controller/saved_cards_controller.dart';

class SavedCardsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedCardsController());
  }
}
