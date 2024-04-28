// ignore_for_file: unused_element
import 'package:auth_task/ui/auth/sign_in/sign_in_screen.dart';
import 'package:auth_task/ui/auth/sign_up/sign_up_view_model.dart';
import 'package:auth_task/core/constants/styles.dart';
import 'package:auth_task/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(

            ///
            /// Start Body
            ///
            body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "User Login Sucessfully!!",
                style: heading24,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextButton(
                  onPressed: () {
                    model.userLogout();
                  },
                  child: Text(
                    "Logout",
                    style: heading20,
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
