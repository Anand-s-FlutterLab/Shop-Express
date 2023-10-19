import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/add_product_screen/model/add_product_model.dart';

class AddProductController extends GetxController {
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<String> imageUrls = [];
  final Map<String, String> productDetails = <String, String>{};

  TextEditingController productIDController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productBrandController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productDisplayPriceController = TextEditingController();

  RxBool isAddProductPressed = false.obs;
  RxList<TextEditingController> labelControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> valueControllers =
      <TextEditingController>[].obs;
  RxList<Rx<File?>> productImages = <Rx<File?>>[].obs;

  @override
  void onClose() {
    super.onClose();
    productIDController.dispose();
    productCategoryController.dispose();
    productBrandController.dispose();
    productDiscountController.dispose();
    productDisplayPriceController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    productNameController.dispose();
    if (labelControllers.isNotEmpty) {
      for (var i = 0; i < labelControllers.length; i++) {
        labelControllers[i].dispose();
        valueControllers[i].dispose();
      }
    }
  }

  double getDiscountedPrice() {
    if (productPriceController.text.isEmpty ||
        productDiscountController.text.isEmpty) {
      return 0.0;
    } else {
      double price = double.parse(productPriceController.text);
      double disc = double.parse(productDiscountController.text);
      double displayPrice = price - (price * disc / 100);
      return displayPrice;
    }
  }

  Future<void> openImagePicker(int index) async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      productImages[index].value = File(pickedImage.path);
    }
  }

  Future<void> uploadImagesAndAddProductToFirebase() async {
    isAddProductPressed.value = true;
    if (valueControllers.isNotEmpty) {
      buildProductDetails();
    }
    String productId = productIDController.text;

    await uploadImages(productId);

    AddProductModel product = AddProductModel(
      productId: productIDController.text,
      productName: productNameController.text,
      productBrand: productBrandController.text,
      productCategory: productCategoryController.text,
      productDescription: productDescriptionController.text,
      productPrice: double.parse(productPriceController.text),
      productDiscount: double.parse(productDiscountController.text),
      productDisplayPrice: double.parse(productDisplayPriceController.text),
      displayImageLink: "",
      productImages: [],
      productDetails: productDetails,
    );

    await addProductToFireStore(product, imageUrls);
    customSnackBar(
        "Item Added", "The item has been added successfully.", "green");
    deleteEverything();
    isAddProductPressed.value = false;
  }

  Future<List<String>> uploadImages(String productId) async {
    try {
      await Firebase.initializeApp();
      final FirebaseStorage storage = FirebaseStorage.instance;

      for (int i = 0; i < productImages.length; i++) {
        final File? image = productImages[i].value;
        final String imageName = 'image_$i.jpg';
        final String imagePath = 'Products/$productId/$imageName';

        UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        final String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    } catch (error) {
      print('Error uploading images: $error');
    }
    return imageUrls;
  }

  Future<void> addProductToFireStore(
      AddProductModel product, List<String> imageUrls) async {
    try {
      final DocumentReference productDoc = FirebaseFirestore.instance
          .collection(collectionProduct)
          .doc(productIDController.text);

      await productDoc.set({
        'productId': product.productId,
        'productName': product.productName,
        'productBrand': product.productBrand,
        'productCategory': product.productCategory,
        'productDescription': product.productDescription,
        'productPrice': product.productPrice,
        'productDiscount': product.productDiscount,
        'productDisplayPrice': product.productDisplayPrice,
        'displayImageLink': imageUrls[0],
        'productImages': imageUrls,
        'productDetails': product.productDetails,
      });
      print('Product added to Firestore successfully');
    } catch (error) {
      print('Error adding product to Firestore: $error');
    }
  }

  void addTextEditingController() {
    TextEditingController valueController = TextEditingController();
    TextEditingController labelController = TextEditingController();
    valueControllers.add(valueController);
    labelControllers.add(labelController);
  }

  void addProductImageFile() {
    Rx<File?> image = Rx<File?>(null);
    productImages.add(image);
  }

  void deleteEverything() {
    imageUrls.clear();
    productImages.clear();
    labelControllers.clear();
    valueControllers.clear();
    productIDController.clear();
    productNameController.clear();
    productBrandController.clear();
    productCategoryController.clear();
    productDescriptionController.clear();
    productPriceController.clear();
    productDiscountController.clear();
    productDisplayPriceController.clear();
  }

  void buildProductDetails() {
    for (var i = 0; i < valueControllers.length; i++) {
      productDetails[labelControllers[i].text] = valueControllers[i].text;
    }
  }
}
