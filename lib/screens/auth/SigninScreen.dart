import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulstan_admin/components/Validators.dart';
import 'package:gulstan_admin/components/constants.dart';
import 'package:gulstan_admin/components/controllers.dart';
import 'package:gulstan_admin/responsive.dart';
import 'package:gulstan_admin/screens/auth/SignUpScreen.dart';
import 'package:gulstan_admin/screens/components/app_logo.dart';
import 'package:gulstan_admin/screens/components/form_input_with_icon.dart';
import 'package:gulstan_admin/screens/components/form_vartical_space.dart';
import 'package:gulstan_admin/screens/components/label_button.dart';
import 'package:gulstan_admin/screens/components/primary_button.dart';

import 'ResetPasswordScreen.dart';

class SignInScreen extends StatelessWidget {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    LogoGraphicHeader(),
                    SizedBox(height: 48.0),
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
                        labelText: 'auth.signInButton'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            authController.signInWithEmailAndPassword(context);
                          }
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: 'auth.resetPasswordLabelButton'.tr,
                      onPressed: () => Get.to(ResetPasswordScreen()),
                    ),
                    LabelButton(
                      labelText: 'auth.signUpLabelButton'.tr,
                      onPressed: () => Get.to(SignUpScreen()),
                    ),
                    SizedBox(height: defaultPadding),
                   
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

