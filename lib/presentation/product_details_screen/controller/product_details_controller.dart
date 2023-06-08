import 'package:shopexpress/core/app_export.dart';

import '../model/product_details_model.dart';

class ProductDetailsController extends GetxController {
  TextEditingController quantityController = TextEditingController();
  RxInt currentQuantity = 1.obs;
  RxBool isDataFetched = false.obs;
  late ProductDetailsModel product;
  RxDouble currentPage = 0.0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    getFireStoreData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> getFireStoreData() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('products')
        .doc(globalProductID.value)
        .get();

    product = ProductDetailsModel.fromFirestore(
        document.data() as Map<String, dynamic>);
    currentPage.value = product.productImages.length.toDouble();
    pageController =
        PageController(initialPage: product.productImages.length);
    pageController.addListener(() {
      currentPage.value = pageController.page!;
    });
    isDataFetched.value = true;
    isDataFetched.refresh();
  }
}
