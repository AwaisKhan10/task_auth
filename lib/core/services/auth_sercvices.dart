// ignore_for_file: unnecessary_this

import 'dart:core';
import 'package:auth_task/core/model/app_user.dart';
import 'package:auth_task/core/model/custom_auth_result.dart';
import 'package:auth_task/core/model/body/login_body.dart';
import 'package:auth_task/core/services/auth_exception_services.dart';
import 'package:auth_task/core/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _dbService = DataBaseServices();
  CustomAuthResult customAuthResult = CustomAuthResult();
  User? user;
  bool isLogin = false;
  AppUser appUser = AppUser();
  AppUser signUpUser = AppUser();

  AuthService() {
    init();
  }

  init() async {
    user = _auth.currentUser;
    if (user != null) {
      isLogin = true;

      appUser = (await _dbService.getAppUser(user!.uid));
    } else {
      isLogin = false;
    }
  }

  ///
  // [SignUp] with email password function
  //

  Future<CustomAuthResult> signUpWithEmailPassword(AppUser appUser) async {
    debugPrint('@services/singUpWithEmailPassword');
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: appUser.email!.trim(), password: appUser.password!.trim());

      if (credential.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }
      if (credential.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credential.user;
        this.appUser = appUser;
        this.appUser.id = credential.user!.uid;

        await _dbService.registerAppUser(appUser);
      }
    } catch (e) {
      debugPrint('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  //
  // [Login] with email and password funnction
  Future<CustomAuthResult> loginWithEmailPassword(LoginBody loginBody) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: loginBody.email!, password: loginBody.password!);

      if (credential.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined error happened';
      }

      ///
      /// if auth is successful
      ///
      if (credential.user != null) {
        appUser = await _dbService.getAppUser(credential.user!.uid);

        customAuthResult.status = true;
        customAuthResult.user = credential.user;
      }
    } catch (e, s) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  /// Logout
  ///
  logout({id}) async {
    try {
      await _auth.signOut();
      this.isLogin = false;
      this.user = null;
      this.customAuthResult = CustomAuthResult();
      this.appUser = AppUser();
      return true;
    } catch (e) {
      print("Exception@authService/Logout ==> $e");
      return false;
    }
  }
}

// /
// /     ************** Another Code  ********************
// /
// ignore_for_file: unnecessary_this, unused_element, avoid_print

// import 'dart:core';
// import 'package:auth_task/core/model/app_user.dart';
// import 'package:auth_task/core/model/body/login_body.dart';
// import 'package:auth_task/core/model/custom_auth_result.dart';
// import 'package:auth_task/core/services/auth_exception_services.dart';
// import 'package:auth_task/core/services/database_services.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthService extends ChangeNotifier {
//   final _auth = FirebaseAuth.instance;
//   final _dbService = DataBaseServices();
//   CustomAuthResult customAuthResult = CustomAuthResult();
//   User? user;
//   bool isLogin = false;
//   AppUser appUser = AppUser();
//   AppUser signUpUser = AppUser();
//   final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
//   String? _deviceId;

//   AuthService();

//   init(BuildContext context) async {
//     user = _auth.currentUser;
//     if (user != null) {
//       isLogin = true;
//       appUser = await _dbService.getAppUser(user!.uid);
//     } else {
//       isLogin = false;
//     }
//     _deviceId = await _getDeviceId(context);
//   }

//   Future<String?> _getDeviceId(BuildContext context) async {
//     String? deviceId;
//     try {
//       if (Theme.of(context).platform == TargetPlatform.iOS) {
//         final IosDeviceInfo iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
//         deviceId = iosDeviceInfo.identifierForVendor;
//       } else if (Theme.of(context).platform == TargetPlatform.android) {
//         final AndroidDeviceInfo androidDeviceInfo =
//             await _deviceInfoPlugin.androidInfo;
//         deviceId = androidDeviceInfo.id;
//       } else {
//         print("Unsupported platform");
//       }
//     } catch (e) {
//       print("Error getting device ID: $e");
//     }
//     return deviceId;
//   }

//   Future<void> _updateUserDevice(String deviceId) async {
//     User? currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       try {
//         await _dbService.updateUserDevice(currentUser.uid, deviceId);
//       } catch (e) {
//         print("Error updating user device: $e");
//       }
//     }
//   }

//   ///
//   // [SignUp] with email password function
//   //

//   Future<CustomAuthResult> signUpWithEmailPassword(AppUser appUser) async {
//     debugPrint('@services/singUpWithEmailPassword');
//     try {
//       final credential = await _auth.createUserWithEmailAndPassword(
//           email: appUser.email!.trim(), password: appUser.password!.trim());

//       if (credential.user == null) {
//         customAuthResult.status = false;
//         customAuthResult.errorMessage = 'An undefined Error happened.';
//       }
//       if (credential.user != null) {
//         customAuthResult.status = true;
//         customAuthResult.user = credential.user;
//         this.appUser = appUser;
//         this.appUser.id = credential.user!.uid;

//         await _dbService.registerAppUser(appUser);
//       }
//     } catch (e) {
//       debugPrint('Exception @sighupWithEmailPassword: $e');
//       customAuthResult.status = false;
//       customAuthResult.errorMessage =
//           AuthExceptionsService.generateExceptionMessage(e);
//     }
//     return customAuthResult;
//   }

//   _handleLogin(LoginBody loginBody) async {
//     // Check if the user is already logged in
//     if (user != null) {
//       // Check if the current device id matches the stored device id
//       if (_deviceId != null && appUser.id == _deviceId) {
//         // If the device id matches, proceed with login
//         await _performLogin(loginBody);
//       } else {
//         // If the device id doesn't match, logout the user from the current device
//         await logout();
//         // Proceed with login after logout
//         await _performLogin(loginBody);
//       }
//     } else {
//       // If the user is not logged in, perform login directly
//       await _performLogin(loginBody);
//     }
//   }

//   Future<void> _performLogin(LoginBody loginBody) async {
//     try {
//       final credential = await _auth.signInWithEmailAndPassword(
//           email: loginBody.email!, password: loginBody.password!);

//       if (credential.user == null) {
//         customAuthResult.status = false;
//         customAuthResult.errorMessage = 'An undefined error happened';
//       } else {
//         // Update user device id after successful login
//         await _updateUserDevice(_deviceId!);

//         // Update local user data
//         user = credential.user;
//         isLogin = true;
//         appUser = await _dbService.getAppUser(user!.uid);

//         customAuthResult.status = true;
//         customAuthResult.user = credential.user;
//       }
//     } catch (e, s) {
//       customAuthResult.status = false;
//       customAuthResult.errorMessage =
//           AuthExceptionsService.generateExceptionMessage(e);
//     }
//   }

//   loginWithEmailPassword(LoginBody loginBody) async {
//     await _handleLogin(loginBody);
//   }
//   // //
//   // // [Login] with email and password funnction
//   // Future<CustomAuthResult> loginWithEmailPassword(LoginBody loginBody) async {
//   //   try {
//   //     final credential = await _auth.signInWithEmailAndPassword(
//   //         email: loginBody.email!, password: loginBody.password!);

//   //     if (credential.user == null) {
//   //       customAuthResult.status = false;
//   //       customAuthResult.errorMessage = 'An undefined error happened';
//   //     }

//   //     ///
//   //     /// if auth is successful
//   //     ///
//   //     if (credential.user != null) {
//   //       appUser = await _dbService.getAppUser(credential.user!.uid);

//   //       customAuthResult.status = true;
//   //       customAuthResult.user = credential.user;
//   //     }
//   //   } catch (e, s) {
//   //     customAuthResult.status = false;
//   //     customAuthResult.errorMessage =
//   //         AuthExceptionsService.generateExceptionMessage(e);
//   //   }
//   //   return customAuthResult;
//   // }

//   ///
//   /// Logout
//   ///
//   logout({id}) async {
//     try {
//       await _auth.signOut();
//       this.isLogin = false;
//       this.user = null;
//       this.customAuthResult = CustomAuthResult();
//       this.appUser = AppUser();
//       return true;
//     } catch (e) {
//       print("Exception@authService/Logout ==> $e");
//       return false;
//     }
//   }
// }
