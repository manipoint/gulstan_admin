import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulstan_admin/components/constants.dart';
import 'package:gulstan_admin/components/controllers.dart';
import 'package:gulstan_admin/controllers/CategoryController.dart';
import 'package:gulstan_admin/screens/components/dropdown_picker.dart';
import 'package:gulstan_admin/screens/components/form_vartical_space.dart';
import 'package:gulstan_admin/screens/components/label_button.dart';
import 'package:gulstan_admin/screens/components/primary_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../responsive.dart';

class AddProduct extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          )),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          width: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 600
              : MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Obx(() => Container(
                    height: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 300
                        : 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: productController.imageFile.value == null
                                ? CustomFileUploadButton(
                                    icon: Icons.image,
                                    labelText: "Add image",
                                    onTap: () async {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext bc) {
                                            return Container(
                                              child: new Wrap(
                                                children: <Widget>[
                                                  new ListTile(
                                                      leading:
                                                          new Icon(Icons.image),
                                                      title: new Text(
                                                          'From gallery'),
                                                      onTap: () async {
                                                        productController
                                                            .getImageFile(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                        Navigator.pop(context);
                                                      }),
                                                  new ListTile(
                                                      leading: new Icon(
                                                          Icons.camera_alt),
                                                      title: new Text(
                                                          'Take a photo'),
                                                      onTap: () async {
                                                        productController
                                                            .getImageFile(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: productController.previewImage())),
                      ],
                    ),
                  )),
              Obx(() => Visibility(
                    visible: productController.imageFile.value != null,
                    child: LabelButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc) {
                              return Container(
                                child: new Wrap(
                                  children: <Widget>[
                                    new ListTile(
                                        leading: new Icon(Icons.image),
                                        title: new Text('From gallery'),
                                        onTap: () async {
                                          productController.getImageFile(
                                              source: ImageSource.gallery);
                                          Navigator.pop(context);
                                        }),
                                    new ListTile(
                                        leading: new Icon(Icons.camera_alt),
                                        title: new Text('Take a photo'),
                                        onTap: () async {
                                          productController.getImageFile(
                                              source: ImageSource.camera);
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              );
                            });
                      },
                      labelText: 'Change Image',
                    ),
                  )),
              Divider(),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Feature"),
                      Obx(() => Switch(
                          value: productController.featured.value,
                          onChanged: (value) {
                            productController.changeFeatured();
                          }))
                    ],
                  )),
              Divider(),
               SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Category:",
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      value: categoryController.selectedCategory.value,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300),
                      icon: Icon(
                        Icons.filter_list,
                        color: primaryColor,
                      ),
                      elevation: 0,
                      onChanged: (value) {
                        categoryController.changeSelectedCategory(
                            newCategory: value!);
                      },
                      items: categoryController.categoriesNames
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value!));
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: TextField(
                      controller: productController.nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Product name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Sen",
                              fontSize: 18)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: TextField(
                      controller: productController.price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Price",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Sen",
                              fontSize: 18)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: TextField(
                      maxLines: 7,
                      controller: productController.descriptionController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Product description",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Sen",
                              fontSize: 18)),
                    ),
                  ),
                ),
              ),
              FormVerticalSpace(),
              PrimaryButton(
                onPressed: () => productController.createNewProduct(categoryController.selectedCategory.value!),
                labelText: 'Upload',
              ),
            ],
          ),
        )),
      ),
    );
  }
}
  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  // Text(
                  //   "Category:",
                  // ),
                  //      DropdownPicker(
                  //   menuOptions: categoryController.categoriesNames,
                  //   selectedOption: categoryController.selectedCategory!,
                  //   onChanged: (value) async {
                  //     await categoryController.changeSelectedCategory(newCategory: value!);
                  //     Get.forceAppUpdate();
                  //   },
                  // ),

                  // DropdownButton<String>(
                  //   value: categoryController.selectedCategory,
                  //   style:
                  //       TextStyle(color:Colors.black, fontWeight: FontWeight.w300),
                  //   icon: Icon(
                  //     Icons.filter_list,
                  //     color: Colors.black,
                  //   ),
                  //   elevation: 0,
                  //   onChanged: (value) {
                  //     categoryController.changeSelectedCategory(newCategory: value!);
                  //   },
                  //   items: categoryController.categoriesNames
                  //       .map<DropdownMenuItem<String>>((String? value) {
                  //     return DropdownMenuItem<String>(
                  //         value: value, child: Text(value!));
                  //   }).toList(),
                  // ),
                  //   ],
                  // ),
