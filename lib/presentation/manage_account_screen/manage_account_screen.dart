import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/manage_account_screen/controller/manage_account_controller.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';

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
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            buildOptionContainer(
              Icons.add_circle,
              "Add new product",
              () => Get.toNamed(AppRoutes.addProductScreen),
            ),
            SizedBox(
              height: 20,
            ),
            buildOptionContainer(
              Icons.manage_history,
              "Manage Item Slider",
              () => Get.toNamed(AppRoutes.manageItemSliderScreen),
            ),
            SizedBox(
              height: 20,
            ),
            buildOptionContainer(
              Icons.manage_search,
              "Manage Product",
                  () => Get.toNamed(AppRoutes.manageProductScreen),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Widget buildOptionContainer(IconData icon, String text, VoidCallback onTap) {
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
              Icon(icon),
              SizedBox(width: 10),
              Text(text, style: GoogleFonts.getFont(
                'Signika Negative',
                fontSize: Get.width * 0.05,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
