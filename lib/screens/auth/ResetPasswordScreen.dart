
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class ResetPasswordScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
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
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'auth.emailFormField'.tr,
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          authController.emailController.text = value as String,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: 'auth.resetPasswordButton'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await authController.sendPasswordResetEmail(context);
                          }
                        }),
                    FormVerticalSpace(),
                    signInLink(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('auth.resetPasswordTitle'));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return LabelButton(
        labelText: 'auth.signInonResetPasswordLabelButton'.tr,
        onPressed: () => Get.offAll(SignInScreen()),
      );
    }
    return Container(width: 0, height: 0);
  }
}