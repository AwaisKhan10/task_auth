import 'package:auth_task/core/enums/view_state.dart';
import 'package:auth_task/core/others/base_view_model.dart';
import 'package:auth_task/core/services/auth_sercvices.dart';
import 'package:auth_task/core/services/database_services.dart';
import 'package:auth_task/locator.dart';
import 'package:auth_task/ui/auth/sign_in/sign_in_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class HomeViewModel extends BaseViewModel {
  ///
  /// locator
  ///
  final currentUser = locator<AuthService>();
  final DataBaseServices _dataBaseServices = DataBaseServices();
  userLogout() async {
    setState(ViewState.busy);
    bool isLogout = await currentUser.logout(id: currentUser.appUser.id!);
    setState(ViewState.idle);
    if (isLogout) {
      Get.offAll(() => SignInScreen());
    }
  }
}
