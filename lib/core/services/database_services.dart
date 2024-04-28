// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_call, avoid_function_literals_in_foreach_calls, non_constant_identifier_names
import 'package:auth_task/core/model/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DataBaseServices {
  final _db = FirebaseFirestore.instance;

  ///
  /// Register app user to firestore database
  ///

  registerAppUser(AppUser user) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db.collection('app_user').doc(user.id).set(user.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser $e');
      debugPrint(s.toString());
      return false;
    }
  }

  Future<void> updateUserDevice(String userId, String deviceId) async {
    try {
      await _db.collection('app_user').doc(userId).update({
        'deviceId': deviceId,
      });
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateUserDevice: $e');
      debugPrint(s.toString());
    }
  }

  ///
  /// Get user from the database using this function
  ///
  Future<AppUser> getAppUser(id) async {
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection("app_user").doc(id).get();
      if (snapshot.exists) {
        debugPrint('Client Data: ${snapshot.data()}');
        return AppUser.fromJson(snapshot.data(), snapshot.id);
      } else {
        return AppUser();
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  uploadImgUrl(AppUser appUser) async {
    try {
      await _db.collection("app_user").doc(appUser.id).update(appUser.toJson());
    } catch (e) {
      print("unable to update");
    }
  }
}
