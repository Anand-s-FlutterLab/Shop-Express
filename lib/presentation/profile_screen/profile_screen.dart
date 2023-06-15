import 'package:flutter/services.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/profile_screen/controller/profile_controller.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(203, 207, 250, 1),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: Get.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color.fromRGBO(203, 207, 250, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.pink.shade50,
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommonImageView(
                            url: defaultProfileImage,
                            height: 100,
                            width: 100,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userName.value,
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: Get.width * 0.1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: controller.isLoading.value
                    ? Container(
                        height: Get.height * 0.5,
                        child: Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.blue, size: 50),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            if (controller.profileModel[index].profileOption ==
                                "Logout") {
                              HapticFeedback.heavyImpact();
                              logoutDialog();
                            } else {
                              Get.toNamed(
                                  "AppRoutes.${controller.profileModel[index].route}");
                            }
                          },
                          leading: CommonImageView(
                            url: controller.profileModel[index].imageAddress,
                            height: 50,
                            width: 50,
                            fit: BoxFit.scaleDown,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                          title: Text(
                            controller.profileModel[index].profileOption,
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              color: Colors.grey,
                              fontSize: Get.width * 0.06,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 25),
                        itemCount: controller.profileModel.length,
                      ),
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Future logoutDialog() {
    return Get.defaultDialog(
        title: "Alert",
        titleStyle: GoogleFonts.getFont(
          'Signika Negative',
        ),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Are you sure want to delete?",
                style: GoogleFonts.getFont(
                  'Signika Negative',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  color: Colors.blue,
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancle",
                    style: GoogleFonts.getFont(
                      'Signika Negative',
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  color: Colors.red,
                  onPressed: () async {
                    HapticFeedback.heavyImpact();
                    controller.onLogout();
                  },
                  child: Text(
                    "delete",
                    style: GoogleFonts.getFont(
                      'Signika Negative',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
