import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/manage_product_screen/model/manage_product_model.dart';

class ManageProductController extends GetxController {
  RxList<ManageProductModel> manageProduct = <ManageProductModel>[].obs;
  RxBool isInitialLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isInitialLoading.value = true;
    fetchProducts();
    isInitialLoading.value = false;
  }

  void fetchProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((snapshot) {
      manageProduct.assignAll(snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return ManageProductModel.fromFirestore(data);
      }).toList());
    });
  }

  Future<void> deleteProductFromFireStore(int index) async {
    try {
      print("trying to delete data from firestore");
      await FirebaseFirestore.instance
          .collection('products')
          .doc(manageProduct[index].productId)
          .delete();
      print('Data deleted from Firestore successfully');
    } catch (error) {
      print('Error deleting data from Firestore: $error');
    }
  }

  Future<void> deleteFolderFromCloudStorage(int index) async {
    try {
      print("trying to delete data from storage");
      String id = manageProduct[index].productId;
      final FirebaseStorage storage = FirebaseStorage.instance;
      final ListResult folderReference =
          await storage.ref().child("Products/$id").listAll();
      for (var i = 0; i < folderReference.items.length; i++) {
        final Reference folderRef =
            storage.ref().child("Products/$id/image_$i.jpg");
        await folderRef.delete();
      }
      print('Folder deleted from Cloud Storage successfully');
    } catch (error) {
      print('Error deleting folder from Cloud Storage: $error');
    }
  }
}
