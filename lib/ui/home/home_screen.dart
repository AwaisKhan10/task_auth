// ignore_for_file: unused_element
import 'package:auth_task/core/constants/colors.dart';
import 'package:auth_task/core/constants/styles.dart';
import 'package:auth_task/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
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
            /// App ABR
            ///
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text(
                "Home Screen",
                style: heading20,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      model.userLogout();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: blackColor,
                    ))
              ],
            ),

            ///
            /// Start Body
            ///
            body: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "User Login Sucessfully!!",
                      style: heading24,
                    ),
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // TextButton(
                  //     onPressed: () {
                  //       Get.to(() => SignInScreen());
                  //     },
                  //     child: Text(
                  //       "Logout",
                  //       style: heading20,
                  //     )),
                ],
              ),
            )),
      ),
    );
  }
}
