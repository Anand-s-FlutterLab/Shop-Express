import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/coupons_screen/controller/coupons_controller.dart';
import 'package:flutter/services.dart';

class CouponsScreen extends GetWidget<CouponsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Coupons",
          style: GoogleFonts.getFont(
            'Signika Negative',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: Get.width * 0.05,
            ),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
      ),
      body: Center(
        child: Obx(() => controller.couponsLoading.value
            ? Text("Loading...")
            : ListView.separated(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  int color1 =
                      int.parse("0xff${controller.coupons[index].color1}");
                  int color2 =
                      int.parse("0xff${controller.coupons[index].color2}");
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipPath(
                        clipper: DolDurmaClipper(
                            right: Get.height * 0.1, holeRadius: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            gradient: LinearGradient(
                                colors: [
                                  Color(color1),
                                  Color(color2),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          width: Get.width - 50,
                          height: Get.height * 0.25,
                          padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                          child: Column(
                            children: [
                              Text(
                                controller.coupons[index].couponName,
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: Get.width * 0.07,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                controller.coupons[index].description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: Get.width * 0.04,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 15,
                        child: GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text: controller.coupons[index].couponName));
                            final snackBar = SnackBar(
                              content: const Text('Coupon Code Copied'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          child: Icon(
                            Icons.copy,
                            size: Get.height * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: controller.coupons.length)),
      ),
    );
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.right, required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height - right - holeRadius)
      ..arcToPoint(
        Offset(size.width, size.height - right),
        clockwise: false,
        radius: Radius.circular(1),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, size.height - right)
      ..arcToPoint(
        Offset(0, size.height - right - holeRadius),
        clockwise: false,
        radius: Radius.circular(1),
      );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
