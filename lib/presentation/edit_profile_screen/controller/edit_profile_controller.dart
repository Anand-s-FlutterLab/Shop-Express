import 'dart:io';

import 'package:shopexpress/core/Utils/common_utils.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/edit_profile_screen/model/edit_profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  late EditProfileModel editProfileModel;
  RxBool isLoading = false.obs;
  RxBool isUpdatePressed = false.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage.value = File(pickedImage.path);
    }
  }

  Future<String> uploadImage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final File? image = profileImage.value;
      const String imageName = 'ProfilePhoto.jpg';
      final String imagePath = '$collectionUsers/${userID.value}/$imageName';

      UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> getProfileData() async {
    isLoading.value = true;
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection(collectionUsers)
        .doc(userID.value)
        .get();
    editProfileModel =
        EditProfileModel.fromJson(document.data() as Map<String, dynamic>);
    firstNameController.text = editProfileModel.firstName;
    lastNameController.text = editProfileModel.lastName;
    emailController.text = editProfileModel.email;
    mobileNumberController.text =
        editProfileModel.mobileNumber.toString().length > 5
            ? editProfileModel.mobileNumber.toString()
            : "";

    isLoading.value = false;
  }

  Future<void> updateProfile() async {
    isUpdatePressed.value = true;
    int mobileNumber = int.parse(mobileNumberController.text);
    String profileUrl = "";

    if (profileImage.value != null) {
      profileUrl = await uploadImage();
    }

    if (editProfileModel.firstName != firstNameController.text ||
        editProfileModel.lastName != lastNameController.text ||
        editProfileModel.email != emailController.text ||
        editProfileModel.mobileNumber != mobileNumber ||
        profileUrl != "") {
      editProfileModel = editProfileModel.copyWith(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        mobileNumber: mobileNumber,
        profileUrl: profileUrl,
      );
      userName.value = firstNameController.text;
      userName.refresh();
      writeStorage(storageUserFirstName, firstNameController.text);

      await FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value)
          .update(editProfileModel.toJson());
      customSnackBar(
          "Success", "Profile has been updated successfully", 'green');
      isUpdatePressed.value = false;
    } else {
      customSnackBar("No Changes", "No modifications have been made.", 'blue');
      isUpdatePressed.value = false;
    }
  }
}
