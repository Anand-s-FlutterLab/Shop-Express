import 'dart:math';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/widgets/common_image_view.dart';
import 'package:shopexpress/widgets/counter_button.dart';
import 'package:shopexpress/presentation/product_details_screen/controller/product_details_controller.dart';

class ProductDetailsScreen extends GetWidget<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Obx(
        () => controller.isDataFetched.value
            ? Stack(children: [
                CustomScrollView(slivers: [
                  SliverAppBar(
                    shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                        ),
                        borderSide: BorderSide.none),
                    backgroundColor: Colors.grey.shade100,
                    elevation: 0,
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: () {
                        selectedBottomNavigationIndex = 0;
                        Get.back();
                      },
                      child:
                          const Icon(Icons.arrow_back_ios, color: Colors.grey),
                    ),
                    expandedHeight: Get.height * 0.50,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        height: Get.height * 0.5,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: Get.height * 0.5,
                              width: Get.width * 0.95,
                              child: Obx(() {
                                final images = controller.product.productImages;
                                final currentPage =
                                    controller.currentPage.value;

                                return LayoutBuilder(
                                  builder: (context, boxConstraints) {
                                    List<Widget> cards = [];

                                    for (int i = 0; i < images.length; i++) {
                                      double currentPageValue = i - currentPage;
                                      bool pageLocation = currentPageValue > 0;

                                      double start = 20 +
                                          max(
                                            (boxConstraints.maxWidth -
                                                    Get.width * .75) -
                                                ((boxConstraints.maxWidth -
                                                            Get.width * .75) /
                                                        2) *
                                                    -currentPageValue *
                                                    (pageLocation ? 9 : 1),
                                            0.0,
                                          );

                                      var customizableCard =
                                          Positioned.directional(
                                        top: 20 +
                                            30 * max(-currentPageValue, 0.0),
                                        bottom: 20 +
                                            30 * max(-currentPageValue, 0.0),
                                        start: start,
                                        textDirection: TextDirection.ltr,
                                        child: Container(
                                          height: Get.width * .67,
                                          width: Get.width * .67,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.15),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CommonImageView(
                                              url: controller
                                                  .product.productImages[i],
                                            ),
                                          ),
                                        ),
                                      );
                                      cards.add(customizableCard);
                                    }
                                    return Stack(children: cards);
                                  },
                                );
                              }),
                            ),
                            Positioned.fill(
                              child: PageView.builder(
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount:
                                    controller.product.productImages.length,
                                controller: controller.pageController,
                                onPageChanged: (index) {
                                  controller.currentPage.value =
                                      index.toDouble();
                                },
                                itemBuilder: (context, index) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 375),
                                childAnimationBuilder: (widget) =>
                                    FadeInAnimation(
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: Duration(milliseconds: 500),
                                      child: ScaleAnimation(
                                        delay: Duration(milliseconds: 75),
                                        scale: 1.5,
                                        child: widget,
                                      ),
                                    ),
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        controller.product.productBrand,
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          fontSize: Get.width * 0.03,
                                        ),
                                      ),
                                      Spacer(),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () =>
                                              controller.toggleFavorite(),
                                          child: Icon(
                                            controller.product.isFavorite.value
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: controller
                                                    .product.isFavorite.value
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.product.productName,
                                    style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.06,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${numberFormatter(controller.product.productDisplayPrice)}",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          fontSize: Get.width * 0.06,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.blue.shade400,
                                              Colors.blue.shade800,
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 5),
                                          child: Text(
                                            "${controller.product.productDiscount}% OFF",
                                            style: GoogleFonts.getFont(
                                              'Signika Negative',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: Get.width * 0.045,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "M.R.P: ",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: Get.width * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "₹${numberFormatter(controller.product.productPrice)}",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: Get.width * 0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      childrenPadding: EdgeInsets.zero,
                                      initiallyExpanded: true,
                                      title: Text(
                                        "Product Description:",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          fontSize: Get.width * 0.06,
                                        ),
                                      ),
                                      children: [
                                        Text(
                                          controller.product.productDescription,
                                          style: GoogleFonts.getFont(
                                            'Signika Negative',
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: Get.width * 0.047,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      childrenPadding: EdgeInsets.zero,
                                      initiallyExpanded: true,
                                      title: Text(
                                        "Product Details:",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          fontSize: Get.width * 0.06,
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10.0, 10, 10, 0),
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    _buildProductDetails(
                                                        "Product Name",
                                                        controller.product
                                                            .productName),
                                                    _buildProductDetails(
                                                        "Brand Name",
                                                        controller.product
                                                            .productBrand),
                                                    _buildProductDetails(
                                                        "Product Category",
                                                        controller.product
                                                            .productCategory),
                                                  ],
                                                ),
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    itemCount: controller
                                                        .product
                                                        .productDetails
                                                        .length,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        _buildProductDetails(
                                                            controller
                                                                .product
                                                                .productDetails
                                                                .entries
                                                                .elementAt(
                                                                    index)
                                                                .key,
                                                            controller
                                                                .product
                                                                .productDetails
                                                                .entries
                                                                .elementAt(
                                                                    index)
                                                                .value)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 75),
                                ]),
                          )))
                ]),
                _buldFloatBar(),
              ])
            : Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.blue, size: 50),
              ),
      )),
    );
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }



  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: Get.width * 0.45,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade800]),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              onTap: () {
                controller.addToCartFromProductDetails();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: Get.width * 0.07,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Add to Cart',
                    style: GoogleFonts.getFont(
                      'Signika Negative',
                      color: Colors.white,
                      fontSize: Get.width * 0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CounterButton(
                  icon: const Icon(Icons.remove, color: Colors.blue),
                  onItemSelected: () {
                    if (controller.currentQuantity.value > 1) {
                      controller.currentQuantity.value -= 1;
                    }
                  },
                ),
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Obx(
                      () => TextFormField(
                        onChanged: (value) =>
                            controller.currentQuantity.value = int.parse(value),
                        controller: controller.quantityController
                          ..text = controller.currentQuantity.value.toString(),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration.collapsed(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '',
                        ),
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          fontSize: Get.width * 0.055,
                        ),
                      ),
                    ),
                  ),
                ),
                CounterButton(
                  isLeftButton: false,
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onItemSelected: () {
                    controller.currentQuantity.value += 1;
                  },
                ),
                const Spacer(),
                buildAddCard(),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails(String key, String value) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.31,
              child: Text(
                key,
                style: GoogleFonts.getFont(
                  'Signika Negative',
                  fontSize: Get.width * 0.047,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.51,
              child: Text(
                value,
                style: GoogleFonts.getFont(
                  'Signika Negative',
                  fontSize: Get.width * 0.047,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 3),
          child: _buildLine(),
        ),
      ],
    );
  }
}
