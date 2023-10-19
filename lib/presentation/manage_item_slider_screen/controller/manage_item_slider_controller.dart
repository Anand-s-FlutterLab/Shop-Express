import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/manage_item_slider_screen/model/manage_item_slider_model.dart';

class ManageItemSliderController extends GetxController {
  final GlobalKey<FormState> addItemSliderFormKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productIDController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Rx<File?> productImage = Rx<File?>(null);
  RxBool isUploadPressed = false.obs;
  RxBool isInitialLoading = false.obs;

  RxList<ManageItemSliderModel> itemSliders = <ManageItemSliderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    isInitialLoading.value = true;
    getItemSliderDetails();
    isInitialLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    productIDController.dispose();
    productNameController.dispose();
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      productImage.value = File(pickedImage.path);
    }
  }

  Future<void> uploadImagesAndAddItemSliderToFirebase() async {
    isUploadPressed.value = true;
    isUploadPressed.refresh();
    String imgUrl = await uploadImage();

    ManageItemSliderModel itemSliderModel = ManageItemSliderModel(
      productId: productIDController.text,
      productName: productNameController.text,
      productImage: imgUrl,
    );

    await addItemSliderToFireStore(itemSliderModel);
    getItemSliderDetails();
    isUploadPressed.value = false;
    isUploadPressed.refresh();
    Get.back();
  }

  Future<String> uploadImage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final File? image = productImage.value;
      final String imageName = '${productIDController.text}.jpg';
      final String imagePath = 'Item Slider/$imageName';

      UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> addItemSliderToFireStore(
      ManageItemSliderModel itemSliderModel) async {
    try {
      final DocumentReference productDoc = FirebaseFirestore.instance
          .collection('Item Slider')
          .doc(productIDController.text);

      await productDoc.set({
        'productId': itemSliderModel.productId,
        'productName': itemSliderModel.productName,
        'productImage': itemSliderModel.productImage,
      });
      print('Product added to Firestore successfully');
    } catch (error) {
      print('Error adding product to Firestore: $error');
    }
  }

  Future<void> editItemSlider(int index) async {
    String imgUrl = await uploadImage();
    final updatedItemSlider = ManageItemSliderModel(
      productName: productNameController.text,
      productId: productIDController.text,
      productImage: imgUrl,
    );

    itemSliders[index] = updatedItemSlider;

    Get.back();
  }

  Future<void> getItemSliderDetails() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Item Slider').get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    itemSliders.value = documents.map((document) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null) {
        return ManageItemSliderModel(
          productName: data['productName'] ?? '',
          productId: data['productId'] ?? '',
          productImage: data['productImage'] ?? '',
        );
      } else {
        return ManageItemSliderModel(
          productName: '',
          productId: '',
          productImage: '',
        );
      }
    }).toList();
  }
}
