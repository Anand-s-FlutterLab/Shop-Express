import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopexpress/routes/app_routes.dart';

class PermissionManager extends GetxController {
  @override
  void onInit() {
    super.onInit();
    requestRequiredPermissions();
  }

  static Future<bool> isPermissionGranted(Permission permission) async {
    return !(await permission.status.isDenied ||
        await permission.status.isRestricted);
  }

  static Future<void> askForPermission(Permission permission) async {
    if (!await isPermissionGranted(permission)) {
      await permission.request();
    }
  }

  static Future<void> requestRequiredPermissions() async {
    await askForPermission(Permission.storage);

    if (!await isPermissionGranted(Permission.storage)) {
      Get.offAllNamed(AppRoutes.permissionErrorScreen);
    }
  }
}
