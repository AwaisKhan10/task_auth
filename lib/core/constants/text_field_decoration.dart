import 'package:auth_task/core/constants/colors.dart';
import 'package:auth_task/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final authFieldDecoration = InputDecoration(
  hintText: "",
  hintStyle: heading16.copyWith(
      color: blackColor, fontWeight: FontWeight.normal, fontSize: 16.sp),
  focusColor: blackColor,
  prefixIconColor: blueColor,
  suffixIconColor: blueColor,
  fillColor: Colors.grey,
  filled: true,
  border: InputBorder.none,
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 2.0),
      borderRadius: BorderRadius.circular(15)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 2.0),
      borderRadius: BorderRadius.circular(15)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 2.0),
      borderRadius: BorderRadius.circular(15)),
  disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 2.0),
      borderRadius: BorderRadius.circular(15)),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 2.0),
      borderRadius: BorderRadius.circular(15)),
);
