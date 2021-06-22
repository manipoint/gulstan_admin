import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulstan_admin/components/Validators.dart';
import 'package:gulstan_admin/controllers/AuthController.dart';
import 'package:gulstan_admin/screens/auth/SigninScreen.dart';
import 'package:gulstan_admin/screens/components/app_logo.dart';
import 'package:gulstan_admin/screens/components/form_input_with_icon.dart';
import 'package:gulstan_admin/screens/components/form_vartical_space.dart';
import 'package:gulstan_admin/screens/components/label_button.dart';
import 'package:gulstan_admin/screens/components/primary_button.dart';

import '../../responsive.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: Responsive.isDesktop(context)|| Responsive.isTablet(context) ? 400 : MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    LogoGraphicHeader(),
                    SizedBox(height: 48.0),
                    FormInputFieldWithIcon(
                      controller: authController.nameController,
                      iconPrefix: Icons.person,
                      labelText: 'auth.nameFormField'.tr,
                      validator: Validator().name,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          authController.nameController.text = value!,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'auth.emailFormField'.tr,
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          authController.emailController.text = value!,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.passwordController,
                      iconPrefix: Icons.lock,
                      labelText: 'auth.passwordFormField'.tr,
                      validator: Validator().password,
                      obscureText: true,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          authController.passwordController.text = value!,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: 'auth.signUpButton'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SystemChannels.textInput.invokeMethod(
                                'TextInput.hide'); //to hide the keyboard - if any
                            authController.registerWithEmailAndPassword(context);
                          }
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: 'auth.signInLabelButton'.tr,
                      onPressed: () => Get.to(SignInScreen()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}