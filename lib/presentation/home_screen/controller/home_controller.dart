import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/home_screen/model/home_model.dart';

import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';
import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';

class HomeScreenController extends GetxController {
  RxBool initialLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  RxList<ItemSliderModel> itemSliderModel = <ItemSliderModel>[].obs;
  RxList<CategoryImageModel> categoryImageModel = <CategoryImageModel>[].obs;
  RxList<ImageSliderModel> imageSliderModel = <ImageSliderModel>[].obs;

  void onInit() {
    super.onInit();
    initialLoading.value = true;
    fetchItemSliders();
    fetchCategoryImage();
    fetchImageSlider();
  }

  Future<void> fetchItemSliders() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Item Slider').get();

      snapshot.docs.forEach((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        ItemSliderModel itemSlider = ItemSliderModel.fromJson(data);
        itemSliderModel.add(itemSlider);
      });
    } catch (error) {
      initialLoading.value = false;
      print('Error fetching item sliders: $error');
    }
  }

  Future<void> fetchCategoryImage() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Category Images').get();

      snapshot.docs.forEach((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        CategoryImageModel categoryImage = CategoryImageModel.fromJson(data);
        categoryImageModel.add(categoryImage);
      });
    } catch (error) {
      initialLoading.value = false;
      print('Error fetching Category Images: $error');
    }
  }

  Future<void> fetchImageSlider() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('productDiscount', descending: true)
          .limit(5)
          .get();

      snapshot.docs.forEach((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        ImageSliderModel imageSlider = ImageSliderModel.fromJson(data);
        imageSliderModel.add(imageSlider);
      });
      initialLoading.value = false;
    } catch (error) {
      initialLoading.value = false;
      print('Error fetching Image Slider: $error');
    }
  }

  void toggleFavorite(int index) async {
    imageSliderModel[index].isFavorite.value = !imageSliderModel[index].isFavorite.value;

    await updateFavoriteStatus(
        imageSliderModel[index].productId, imageSliderModel[index].isFavorite.value);
  }

  Future<void> updateFavoriteStatus(String productId, bool isFavorite) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({'isFavorite': isFavorite});
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  void addToCartFromHomeImageSlider(int index) {
    final cartItem = CartItem(
      productId: imageSliderModel[index].productId,
      productName: imageSliderModel[index].productName,
      productBrand: imageSliderModel[index].productBrand,
      productDisplayPrice: imageSliderModel[index].productDisplayPrice,
      productQuantity: 1.obs,
      displayImageLink: imageSliderModel[index].displayImageLink,
    );

    final cartController = Get.find<CartController>();
    cartController.addItemToCart(cartItem);
  }
}
