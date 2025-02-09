import 'package:flutter/material.dart';
import 'package:the_address_investments_ecommerce/core/utils/app_colors.dart';

class AppTheme{
  static ThemeData themeData =  ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightGrey
    ),
    scaffoldBackgroundColor: AppColors.lightGrey,
    primaryColor: AppColors.primary,
    fontFamily: 'Inter',
  );
}