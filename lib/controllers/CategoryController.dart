import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gulstan_admin/components/firebase.dart';
import 'package:gulstan_admin/models/category.dart';

class CategoryController extends GetxController {
  static CategoryController to = Get.find();
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  List<String?> categoriesNames = [];
  String? selectedCategory;
  String collection = "categories";
  @override
  void onReady() {
    super.onReady();
    categories.bindStream(getAllCategories());
    //categoriesNames.bindStream(loadCatogery());
  }

  Stream<List<CategoryModel>> getAllCategories() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((query) => query.docs
          .map((item) => CategoryModel.fromJson(item.data()))
          .toList());

  // Future<CategoryModel> getCategories() => firebaseFirestore
  //     .doc(collection)
  //     .get()
  //     .then((value) => CategoryModel.fromJson(value.data()!));
  List<String> cats = ["Pizza", "Burgger", "Ice cream"];
  loadCatogery() {
    for (String ct in cats) {
      categoriesNames.add(ct);
    }
    selectedCategory = categoriesNames[0];
  }

  changeSelectedCategory({required String newCategory}) {
    selectedCategory = newCategory;
    print(selectedCategory);
  }
}
