import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/manage_account_screen/controller/manage_account_controller.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';
import 'package:shopexpress/widgets/common_image_view.dart';

class ManageAccountScreen extends GetWidget<ManageAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Manage Account",
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
      ),
      body: SafeArea(
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => FadeInAnimation(
                  delay: Duration(milliseconds: 100),
                  child: SlideAnimation(
                    horizontalOffset: -50.0,
                    delay: Duration(milliseconds: 60),
                    child: widget,
                  ),
                ),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  buildOptionContainer(
                    0,
                    () => Get.toNamed(AppRoutes.addProductScreen),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildOptionContainer(
                    1,
                    () => Get.toNamed(AppRoutes.manageItemSliderScreen),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildOptionContainer(
                    2,
                    () => Get.toNamed(AppRoutes.manageProductScreen),
                  ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Widget buildOptionContainer(int index, VoidCallback onTap) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: Get.height * 0.08,
          width: Get.width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              CommonImageView(
                url: controller.items.entries.elementAt(index).value,
                height: Get.width * 0.1,
                width: Get.width * 0.1,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Text(
                controller.items.entries.elementAt(index).key,
                style: GoogleFonts.getFont(
                  'Signika Negative',
                  fontSize: Get.width * 0.05,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
