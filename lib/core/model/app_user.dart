// ignore_for_file: unnecessary_this, prefer_initializing_formals

import 'dart:io';

class AppUser {
  String? id;
  String? name;
  String? email;
  String? password;
  String? emailAddress;
  String? imgUrl;
  File? fileImage;
  bool? isProfileCompleted;

  AppUser(
      {this.id,
      this.email,
      this.emailAddress,
      this.password,
      this.name,
      this.fileImage,
      this.isProfileCompleted});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailAddress': emailAddress,
      'password': password,
      'imgUrl': imgUrl,
      'isProfileCompleted': isProfileCompleted,
    };
  }

  AppUser.fromJson(json, id) {
    this.id = id;
    this.name = json['name'] ?? "";
    this.email = json['email'] ?? "";
    this.imgUrl = json['imgUrl'];

    this.isProfileCompleted = json['isProfileCompleted'] ?? false;
  }
}
