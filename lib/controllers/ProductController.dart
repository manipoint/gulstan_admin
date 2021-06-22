import 'dart:io' as file;

// import 'dart:html'as html_file;

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gulstan_admin/components/controllers.dart';
import 'package:gulstan_admin/components/firebase.dart';
import 'package:gulstan_admin/models/category.dart';
import 'package:gulstan_admin/models/product.dart';
import 'package:gulstan_admin/screens/dashboard/dashboard_screen.dart';
import 'package:gulstan_admin/screens/product/addProduct.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  static ProductController to = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final price = TextEditingController();

  String collection = "products";
  Rxn<ProductModel> productModel = Rxn<ProductModel>();
  Rxn<CategoryModel> catModel = Rxn<CategoryModel>();

  Rx<bool> featured = false.obs;
  final ImagePicker _picker = ImagePicker();
  Rx<String> productImageFileName = "".obs;
  Rx<PickedFile?> imageFile = Rxn<PickedFile>();
  dynamic _pickImageError;

  createNewProduct() async {
    String productId = Uuid().v4();
    String imageUrl = await _uploadImageFile(imageFile.value!, productId);
    firebaseFirestore.collection(collection).doc(productId).set({
      "id": productId,
      "name": nameController.text,
      "description": descriptionController.text,
      "price": double.parse(price.text),
      "feature": productController.featured.value,
      "picture": imageUrl,
      "category": "",
      "review": "Tasaty",
      "rating": 4.8,
    }).catchError((error) {
      Get.snackbar("Error", "Failed to add Product");
      print("Failed to add user: $error");
    });
    Get.snackbar("Success", "Product Added Successfully");
    // Get.defaultDialog(
    //   title: "You want to add another file",
    //   onConfirm: ()=>Get.to(AddProduct()),
    //   onCancel: ()=>Get.to(DashboardScreen()),
    // );
  }

  Future<String> _uploadImageFile(
      PickedFile image, String? imageFileName) async {
    print("Uploading File");
    print("File path is ${image.toString()}");
    firebase_storage.UploadTask uploadTask;
    final metadata = firebase_storage.SettableMetadata(
        contentType: imageFileName,
        customMetadata: {'picked-file-path': image.path});

    firebase_storage.Reference reference = storage.ref();
    if (kIsWeb) {
      uploadTask = reference
          .child(collection)
          .child(imageFileName!)
          .putData(await image.readAsBytes(), metadata);
    } else {
      uploadTask = reference
          .child(collection)
          .child(imageFileName!)
          .putFile(file.File(image.path));
    }
    firebase_storage.TaskSnapshot snapshot =
        await uploadTask.then((value) => value);
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  getImageFile({required ImageSource source}) async {
    // print("Geting File");
    try {
      final pickedFile =
          await _picker.getImage(source: source, maxHeight: 400, maxWidth: 600);
      imageFile.value = pickedFile;
      update();
    } catch (error) {
      _pickImageError = error;
      update();
      Get.snackbar("Error", "Unable to get Image");
    }
  }

  previewImage() {
    if (imageFile.value != null) {
      if (kIsWeb) {
        return Image.network(imageFile.value!.path);
      } else {
        return Semantics(
            child: Image.file(file.File(imageFile.value!.path)),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError != null) {
      return Get.snackbar("Error", _pickImageError, colorText: Colors.red);
    } else {
      return Get.snackbar("Error", "You have not yet picked an image",
          colorText: Colors.red);
    }
  }

  changeFeatured() {
    featured.value = !featured.value;
  }
}
