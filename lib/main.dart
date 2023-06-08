import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopexpress/routes/app_routes.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(
    const ShopExpress(),
  );
}

class ShopExpress extends StatelessWidget {
  const ShopExpress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.pages,
    );
  }
}
