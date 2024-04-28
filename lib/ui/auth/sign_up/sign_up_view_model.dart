// ignore_for_file: unused_field

import 'package:auth_task/ui/home/home_screen.dart';
import 'package:auth_task/core/enums/view_state.dart';
import 'package:auth_task/core/model/app_user.dart';
import 'package:auth_task/core/model/custom_auth_result.dart';
import 'package:auth_task/core/others/base_view_model.dart';
import 'package:auth_task/core/services/auth_sercvices.dart';
import 'package:auth_task/core/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignupViewModel extends BaseViewModel {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authService = AuthService();
  final _dbServices = DataBaseServices();
  AppUser appUser = AppUser();
  CustomAuthResult customAuthResult = CustomAuthResult();
  signUpWithEmail() async {
    setState(ViewState.busy);
    // appUser = authService.appUser;
    appUser.id = authService.appUser.id;
    customAuthResult = await authService.signUpWithEmailPassword(appUser);
    setState(ViewState.idle);
    if (customAuthResult.user != null) {
      Get.to((const HomeScreen()));
    } else {
      Get.snackbar("Error!", "${customAuthResult.errorMessage}");
    }
  }
}
