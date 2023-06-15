import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/favorite_screen/controller/favorite_controller.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';

import '../../widgets/common_image_view.dart';

class FavoriteScreen extends GetWidget<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Beloved Picks",
          style: GoogleFonts.getFont(
            'Signika Negative',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: Get.width * 0.07,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 5, right: 5),
          height: Get.height - 25,
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue, size: 50),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.favoriteModel.isEmpty
                            ? SizedBox(
                                height: Get.height - 150,
                                width: Get.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonImageView(
                                      url: nothingFavorite,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      "The favorites section is currently empty.",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.05,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : AnimationLimiter(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => GridView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.74,
                                        ),
                                        itemCount:
                                            controller.favoriteModel.length,
                                        itemBuilder: (context, index) {
                                          return AnimationConfiguration
                                              .staggeredGrid(
                                            position: index,
                                            duration:
                                                Duration(milliseconds: 500),
                                            columnCount: 2,
                                            child: SlideAnimation(
                                              duration:
                                                  Duration(milliseconds: 600),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              horizontalOffset: -100.0,
                                              child: FadeInAnimation(
                                                delay:
                                                    Duration(milliseconds: 100),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    globalProductID.value =
                                                        controller
                                                            .favoriteModel[
                                                                index]
                                                            .productId;
                                                    Get.toNamed(AppRoutes
                                                        .productDetailScreen);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                blurRadius: 5)
                                                          ]),
                                                      child: Stack(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child:
                                                                      CommonImageView(
                                                                    url: controller
                                                                        .favoriteModel[
                                                                            index]
                                                                        .displayImageLink,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    height: 120,
                                                                    width: 120,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                height: 1,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 7,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            13),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          controller
                                                                              .favoriteModel[index]
                                                                              .productBrand,
                                                                          style:
                                                                              GoogleFonts.getFont(
                                                                            'Signika Negative',
                                                                            fontSize:
                                                                                Get.width * 0.03,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          controller
                                                                              .favoriteModel[index]
                                                                              .productName,
                                                                          style:
                                                                              GoogleFonts.getFont(
                                                                            'Signika Negative',
                                                                            fontSize:
                                                                                Get.width * 0.05,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "₹${controller.favoriteModel[index].productPrice}",
                                                                              style: GoogleFonts.getFont(
                                                                                'Signika Negative',
                                                                                decoration: TextDecoration.lineThrough,
                                                                                color: Colors.black.withOpacity(0.6),
                                                                                fontSize: Get.width * 0.04,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text(
                                                                              "₹${controller.favoriteModel[index].productDisplayPrice.toStringAsFixed(2)}",
                                                                              style: GoogleFonts.getFont(
                                                                                'Signika Negative',
                                                                                fontSize: Get.width * 0.05,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Positioned(
                                                            top: 5,
                                                            right: 10,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () => controller
                                                                  .updateFavoriteStatus(
                                                                      index),
                                                              child: Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                              colors: [
                                                                            Colors.blue.shade400,
                                                                            Colors.blue.shade800,
                                                                          ]),
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              15),
                                                                          bottomRight:
                                                                              Radius.circular(15))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        7,
                                                                        3,
                                                                        7,
                                                                        3),
                                                                child: Text(
                                                                  "${controller.favoriteModel[index].productDiscount}% OFF",
                                                                  style: GoogleFonts
                                                                      .getFont(
                                                                    'Signika Negative',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.035,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            right: 0,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () => controller
                                                                  .addToCartFromFavorite(
                                                                      index),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                                colors: [
                                                                              Colors.blue.shade400,
                                                                              Colors.blue.shade800,
                                                                            ]),
                                                                        borderRadius: const BorderRadius.only(
                                                                            bottomRight:
                                                                                Radius.circular(15),
                                                                            topLeft: Radius.circular(15))),
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
