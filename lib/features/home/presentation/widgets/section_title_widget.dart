import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({super.key, required this.fontSize, required this.title});
  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r,),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter",
        ),
      ),
    );
  }
}
