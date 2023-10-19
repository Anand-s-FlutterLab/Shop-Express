import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopexpress/core/Utils/common_utils.dart';
import 'package:shopexpress/core/app_export.dart';

import 'package:shopexpress/core/Network/network_info.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            if (FirebaseAuth.instance.currentUser != null) {
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                Get.offNamed(AppRoutes.homeScreen);
              } else {
                Get.offNamed(AppRoutes.emailVerificationScreen);
              }
            } else {
              Get.offNamed(AppRoutes.loginScreen);
            }
            Timer(Duration(milliseconds: 300), () {
              scaleController.reset();
            });
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  'ShopExpress',
                  style: GoogleFonts.getFont('Signika Negative',
                      fontSize: Get.width * 0.1,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 6),
              opacity: _opacity,
              child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(seconds: 3),
                height: _value ? 50 : 300,
                width: _value ? 50 : 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(.2),
                      blurRadius: 100,
                      spreadRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(appLogo),
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: AnimatedBuilder(
                        animation: scaleAnimation,
                        builder: (c, child) => Transform.scale(
                          scale: scaleAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
