import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopexpress/routes/app_routes.dart';
import 'package:shopexpress/core/Utils/initial_binding.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(
    ShopExpress(),
  );
}

class ShopExpress extends StatelessWidget {
  ShopExpress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop Express',
        initialRoute: AppRoutes.splashScreen,
        getPages: AppRoutes.pages,
        initialBinding: InitialBindings());
  }
}
