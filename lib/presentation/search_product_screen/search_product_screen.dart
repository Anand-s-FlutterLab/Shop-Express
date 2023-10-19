import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/search_product_screen/controller/search_product_controller.dart';
import 'package:shopexpress/widgets/common_image_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SearchProductScreen extends GetWidget<SearchProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: Get.width - 55,
                                height: 50,
                                child: TextFormField(
                                  onChanged: (value) {
                                    customSearch.value = value;
                                  },
                                  onFieldSubmitted: (value) {
                                    controller.getProductItems();
                                  },
                                  controller: controller.searchController,
                                  style: GoogleFonts.getFont(
                                    'Signika Negative',
                                    fontSize: Get.width * 0.05,
                                  ),
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
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.searchController.clear();
                                        customSearch.value = "";
                                      },
                                      child: customSearch.value.isEmpty
                                          ? SizedBox()
                                          : Icon(
                                              Icons.clear,
                                              color: Colors.black,
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
                        if (controller.products.isEmpty)
                          SizedBox(
                            height: Get.height - 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonImageView(url: noResultFound),
                                Text(
                                  "Apologies, but your search yielded no fruitful outcomes.",
                                  style: GoogleFonts.getFont(
                                    'Signika Negative',
                                    fontSize: Get.width * 0.05,
                                  ),
                                )
                              ],
                            ),
                          )
                        else
                          AnimationLimiter(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.74,
                              ),
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: Duration(milliseconds: 500),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    duration: Duration(milliseconds: 900),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    scale: 1.5,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap: () {
                                          globalProductID.value = controller
                                              .products[index].productId;
                                          Get.toNamed(
                                              AppRoutes.productDetailScreen);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 5)
                                                ]),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: CommonImageView(
                                                          url: controller
                                                              .products[index]
                                                              .displayImageLink,
                                                          fit: BoxFit.contain,
                                                          height: 120,
                                                          width: 120,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      height: 1,
                                                    ),
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 13),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .products[
                                                                        index]
                                                                    .productBrand,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Signika Negative',
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.03,
                                                                ),
                                                              ),
                                                              Text(
                                                                controller
                                                                    .products[
                                                                        index]
                                                                    .productName,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Signika Negative',
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.05,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "₹${numberFormatter(controller.products[index].productPrice)}",
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Signika Negative',
                                                                        decoration:
                                                                            TextDecoration.lineThrough,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.6),
                                                                        fontSize:
                                                                            Get.width *
                                                                                0.04,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      "₹${numberFormatter(controller.products[index].productDisplayPrice)}",
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Signika Negative',
                                                                        fontSize:
                                                                            Get.width *
                                                                                0.05,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
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
                                                  child: Obx(
                                                    () => GestureDetector(
                                                      onTap: () => controller
                                                          .toggleFavorite(
                                                              index),
                                                      child: Icon(
                                                        controller
                                                                .products[index]
                                                                .isFavorite
                                                                .value
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: controller
                                                                .products[index]
                                                                .isFavorite
                                                                .value
                                                            ? Colors.red
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Colors.blue
                                                                  .shade400,
                                                              Colors.blue
                                                                  .shade800,
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(7, 3, 7, 3),
                                                      child: Text(
                                                        "${controller.products[index].productDiscount}% OFF",
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Signika Negative',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize:
                                                              Get.width * 0.035,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () => controller
                                                        .addToCartFromSearchProduct(
                                                            index),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Colors.blue
                                                                    .shade400,
                                                                Colors.blue
                                                                    .shade800,
                                                              ]),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                              15),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15))),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
