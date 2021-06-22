import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gulstan_admin/components/AppRouts.dart';
import 'package:gulstan_admin/components/firebase.dart';
import 'package:gulstan_admin/controllers/MenuController.dart';
import 'package:gulstan_admin/screens/components/loading.dart';

import 'components/AppThemes.dart';
import 'components/localization.g.dart';
import 'controllers/AuthController.dart';
import 'controllers/CategoryController.dart';
import 'controllers/LangagueController.dart';
import 'controllers/ProductController.dart';
import 'controllers/TheamController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization.then((value) {
  Get.put(AuthController());
  Get.put(ThemeController());
  Get.put(LanguageController());
  Get.put<MenuController>(MenuController());
  Get.put(CategoryController());
  Get.put(ProductController());
  });
  await GetStorage.init();
  

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
    
        builder: (languageController) => Loading(
                child: GetMaterialApp(
              translations: Localization(),
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: ThemeMode.system,
              locale: languageController.getLocale,
              debugShowCheckedModeBanner: false,
              title: 'Gulstan Admin',
              initialRoute: "/",
              getPages: AppRoutes.routes,
            )));
  }
}
