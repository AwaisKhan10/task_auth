// ignore_for_file: unused_element, use_key_in_widget_constructors, prefer_is_empty
import 'package:auth_task/ui/auth/sign_in/sign_view_model.dart';
import 'package:auth_task/ui/auth/sign_up/sign_up_screen.dart';
import 'package:auth_task/core/constants/text_field_decoration.dart';
import 'package:auth_task/core/constants/colors.dart';
import 'package:auth_task/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SigninViewModel(),
      child: Consumer<SigninViewModel>(
        builder: (context, model, child) => Scaffold(

            ///
            /// Start Body
            ///
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),

                  ///
                  /// Sign Up
                  ///
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign In',
                      style: heading24.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: model.emailController,
                    decoration: authFieldDecoration.copyWith(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (!val.toString().trim().isEmail) {
                        return 'Please Enter a valid Email';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      model.loginBody.email = val.trim();
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  ///
                  /// Passowrd
                  ///
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: model.passwordController,
                    decoration:
                        authFieldDecoration.copyWith(hintText: 'Passowrd'),
                    validator: (val) {
                      if (val!.length < 1 || val!.isEmpty) {
                        return 'Please Enter your Password';
                      } else if (val!.length < 8) {
                        return 'Password must include 8 characters';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      model.loginBody.password = value;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  ///
                  /// Sign Up Button
                  ///
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await model.requesForLogin();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.green[800],
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Text(
                        "Sign In",
                        style: heading16.copyWith(color: whiteColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "I have not  Account? ", style: heading16),
                      TextSpan(
                          text: "Sign Up",
                          style: heading16.copyWith(
                              color: Colors.red, fontWeight: FontWeight.w600)),
                    ])),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
