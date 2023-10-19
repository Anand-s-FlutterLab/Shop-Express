import 'package:shopexpress/core/Utils/permission_manager.dart';
import 'package:shopexpress/core/Utils/storage_data.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';
import 'package:shopexpress/core/Utils/precached_network_image.dart';
import 'package:shopexpress/core/Network/network_info.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController());
    Get.put(CartController());
    Get.put(PermissionManager());
    Get.put(InitialDataLoad());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final context = Get.context;
      if (context != null && !isImagePrecached.value) {
        await preCacheFirebaseImage(context);
      } else {
        print("Null Context");
      }
    });
  }
}
