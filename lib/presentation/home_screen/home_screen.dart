import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/home_screen/controller/home_controller.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopexpress/widgets/common_image_view.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => controller.initialLoading.value
                ? SizedBox(
                    height: Get.height,
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.blue, size: 50),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: Get.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width - 30,
                              height: 50,
                              child: TextFormField(
                                onChanged: (value) {
                                  customSearch.value = value;
                                },
                                onFieldSubmitted: (value) {
                                  controller.searchController.clear();
                                  Get.toNamed(AppRoutes.searchProductScreen);
                                },
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  fontSize: Get.width * 0.05,
                                ),
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.black),
                                  suffixIcon: Obx(
                                    () => customSearch.value.isEmpty
                                        ? SizedBox()
                                        : GestureDetector(
                                            onTap: () {
                                              controller.searchController
                                                  .clear();
                                              customSearch.value = "";
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Search Here",
                                  hintStyle: GoogleFonts.getFont(
                                    'Signika Negative',
                                    fontSize: Get.width * 0.05,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          height: Get.height * 0.25,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount: controller.itemSliderModel.length,
                        itemBuilder: (context, index, realIndex) =>
                            GestureDetector(
                          onTap: () {
                            globalProductID.value =
                                controller.itemSliderModel[index].productId;
                            Get.toNamed(AppRoutes.productDetailScreen);
                          },
                          child: CommonImageView(
                            url: controller.itemSliderModel[index].productImage,
                            width: Get.width,
                            height: Get.height * 0.3,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Text(
                        "Shop by Category",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          fontSize: Get.width * 0.06,
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: Get.height * 0.31,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: (controller.categoryImageModel.length %
                                      2 ==
                                  0)
                              ? controller.categoryImageModel.length ~/ 2
                              : (controller.categoryImageModel.length ~/ 2) + 1,
                          itemBuilder: (context, index) {
                            final itemIndex = index * 2;

                            if (itemIndex <
                                controller.categoryImageModel.length) {
                              return Column(
                                children: [
                                  categoryImageBuilder(itemIndex),
                                  const SizedBox(height: 20),
                                  if (itemIndex + 1 <
                                      controller.categoryImageModel.length)
                                    categoryImageBuilder(itemIndex + 1),
                                ],
                              );
                            } else {
                              return SizedBox
                                  .shrink(); // Return an empty SizedBox for excess indices
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Text(
                        "Popular Picks",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          fontSize: Get.width * 0.06,
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 251,
                        child: ListView.separated(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8.0, bottom: 8.0),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  globalProductID.value = controller
                                      .imageSliderModel[index].productId;
                                  Get.toNamed(AppRoutes.productDetailScreen);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 7)
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(7, 7, 7, 7),
                                          color: Colors.white,
                                          child: CommonImageView(
                                            url: controller
                                                .imageSliderModel[index]
                                                .displayImageLink,
                                            fit: BoxFit.fitWidth,
                                            height: 150,
                                            width: 150,
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          height: 70,
                                          width: 164,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft:
                                                    Radius.circular(15)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .imageSliderModel[index]
                                                    .productBrand,
                                                style: GoogleFonts.getFont(
                                                  'Signika Negative',
                                                  fontSize: Get.width * 0.04,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  controller
                                                      .imageSliderModel[index]
                                                      .productName,
                                                  style: GoogleFonts.getFont(
                                                    'Signika Negative',
                                                    fontSize: Get.width * 0.06,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "Price: ₹${controller.imageSliderModel[index].productDisplayPrice.toStringAsFixed(2)}",
                                                  style: GoogleFonts.getFont(
                                                    'Signika Negative',
                                                    fontSize: Get.width * 0.05,
                                                  ),
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
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 15,
                                ),
                            itemCount: controller.imageSliderModel.length),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Widget categoryImageBuilder(int index) {
    return GestureDetector(
      onTap: () => {
        customSearch.value = "",
        selectedCategory.value =
            controller.categoryImageModel[index].categoryName,
        if (selectedCategory.value == "Special Offer")
          {isSpecialOfferSelected.value = true},
        Get.toNamed(AppRoutes.searchProductScreen)
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        height: Get.height * 0.13,
        width: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10)
            ]),
        child: Column(
          children: [
            CommonImageView(
              url: controller.categoryImageModel[index].categoryImage,
              height: 80,
              width: 80,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                controller.categoryImageModel[index].categoryName,
                maxLines: 1,
                style: GoogleFonts.getFont(
                  'Signika Negative',
                  fontSize: Get.width * 0.045,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
