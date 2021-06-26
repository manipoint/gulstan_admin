import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gulstan_admin/components/firebase.dart';

class CategoryController extends GetxController {
  static CategoryController to = Get.find();

  //RxList<CategoryModel> categories = RxList<CategoryModel>([]);

  RxList<String?> categoriesNames = [''].obs;
  List<String?> categories = [];
  Rx<String?> selectedCategory = "".obs;
  String collection = "categories";

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    //ever(categoriesNames, loadCategories());
  }

  getCategories() async {
    firebaseFirestore
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        categoriesNames.add(element["name"]);
      });
    });
  }

  loadCategories() async {
    categoriesNames = getCategories();
    for (int i = 0; i < categoriesNames.length; i++) {
      categories.add(categoriesNames[i]);
    }
    selectedCategory.value = categories[0];
    update();
  }

  changeSelectedCategory({required String newCategory}) {
    print("cat in cats are ${categories.length}");
    selectedCategory.value = newCategory;
    update();
  }
}
