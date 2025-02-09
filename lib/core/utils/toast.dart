import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_address_investments_ecommerce/core/utils/app_colors.dart';

class CustomToast {
  static void showToast({required String msg, Color? background}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: background ?? AppColors.primary,
      textColor: Colors.white,
      fontSize: 16.sp,
    );
  }
}
