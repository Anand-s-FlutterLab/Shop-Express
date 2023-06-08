import 'package:get/get.dart';
import 'package:shopexpress/presentation/favorite_screen/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }
}
