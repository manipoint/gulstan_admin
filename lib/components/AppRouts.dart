import 'package:get/get.dart';
import 'package:gulstan_admin/screens/SettingScreen.dart';
import 'package:gulstan_admin/screens/SplashScreen.dart';
import 'package:gulstan_admin/screens/auth/ResetPasswordScreen.dart';
import 'package:gulstan_admin/screens/auth/SignUpScreen.dart';
import 'package:gulstan_admin/screens/auth/SigninScreen.dart';
import 'package:gulstan_admin/screens/auth/UpdateProfile.dart';
import 'package:gulstan_admin/screens/main/main_screen.dart';
import 'package:gulstan_admin/screens/product/addProduct.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/signin', page: () => SignInScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/home', page: () => MainScreen()),
    GetPage(name: '/settings', page: () => SettingsScreen()),
    GetPage(name: '/reset-password', page: () => ResetPasswordScreen()),
    GetPage(name: '/update-profile', page: () => UpdateProfileScreen()),
    GetPage(name: '/new-product', page: () => AddProduct()),
  ];
}