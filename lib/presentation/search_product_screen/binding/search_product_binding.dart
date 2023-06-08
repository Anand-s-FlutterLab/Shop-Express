import 'package:get/get.dart';
import 'package:shopexpress/presentation/search_product_screen/controller/search_product_controller.dart';

class SearchProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchProductController());
  }
}
