import 'package:auth_task/ui/home/home_screen.dart';
import 'package:auth_task/core/enums/view_state.dart';
import 'package:auth_task/core/model/custom_auth_result.dart';
import 'package:auth_task/core/model/body/login_body.dart';
import 'package:auth_task/core/others/base_view_model.dart';
import 'package:auth_task/core/services/auth_sercvices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../locator.dart';

class SigninViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBody loginBody = LoginBody();

  final _authService = locator<AuthService>();
  CustomAuthResult customAuthResult = CustomAuthResult();

  requesForLogin() async {
    setState(ViewState.busy);
    customAuthResult = await _authService.loginWithEmailPassword(loginBody);
    setState(ViewState.idle);
    if (customAuthResult.user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.snackbar("Error!", "${customAuthResult.errorMessage}");
    }
  }
}
