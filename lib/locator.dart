import 'package:auth_task/core/services/auth_sercvices.dart';
import 'package:auth_task/core/services/database_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(DataBaseServices());
}
