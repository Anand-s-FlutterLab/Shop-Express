import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopexpress/core/app_export.dart';

import '../core/Utils/permission_manager.dart';

class PermissionErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade400,
            Colors.blue.shade800,
          ])),
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Container(
                  height: Get.height - 175,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60.0)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Permission Denied",
                            style: GoogleFonts.getFont('Signika Negative',
                                fontSize: Get.width * 0.15, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Sorry, but the user has denied the permission. The requested application cannot be accessed.",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.getFont('Signika Negative',
                              fontSize: Get.width * 0.07,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CommonImageView(
                          url: permissionDenied,
                          height: 300,
                          width: 300,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 140,
                width: Get.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      onPressed: () {
                        PermissionManager.requestRequiredPermissions();
                      },
                      height: 80,
                      minWidth: Get.width - 50,
                      color: Colors.white,
                      child: const Text(
                        "Grant Permission",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
