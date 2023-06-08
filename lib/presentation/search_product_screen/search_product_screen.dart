import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/search_product_screen/controller/search_product_controller.dart';
import 'package:shopexpress/routes/app_routes.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';
import 'package:shopexpress/widgets/common_image_view.dart';
import 'package:shopexpress/widgets/search_app_bar.dart';

class SearchProductScreen extends GetWidget<SearchProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchAppBarWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 5, right: 5),
            height: Get.height - 170,
            child: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.blue, size: 50),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            globalProductID.value =
                                controller.products[index].productId;
                            Get.toNamed(AppRoutes.productDetailScreen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 5)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Stack(children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  color: Colors.white,
                                                  child: CommonImageView(
                                                    url: controller
                                                        .products[index]
                                                        .displayImageLink,
                                                    fit: BoxFit.contain,
                                                    height: 130,
                                                    width: 130,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 13),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller
                                                  .products[index].productBrand,
                                              style: GoogleFonts.getFont(
                                                'Signika Negative',
                                                fontSize: Get.width * 0.03,
                                              ),
                                            ),
                                            Text(
                                              controller
                                                  .products[index].productName,
                                              style: GoogleFonts.getFont(
                                                'Signika Negative',
                                                fontSize: Get.width * 0.05,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${controller.products[index].productPrice}",
                                                  style: GoogleFonts.getFont(
                                                    'Signika Negative',
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: Get.width * 0.04,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      // color: Colors.green.shade100.withOpacity(0.7),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Colors
                                                                .blue.shade400,
                                                            Colors
                                                                .blue.shade800,
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
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
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${controller.products[index].productDisplayPrice.toStringAsFixed(2)}",
                                                  style: GoogleFonts.getFont(
                                                    'Signika Negative',
                                                    fontSize: Get.width * 0.05,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.blue.shade400,
                                                          Colors.blue.shade800
                                                        ]),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset:
                                                            const Offset(4, 8),
                                                        blurRadius: 20,
                                                        color: const Color(
                                                                0xFF101010)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  29)),
                                                      onTap: () {},
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons.shopping_cart,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
