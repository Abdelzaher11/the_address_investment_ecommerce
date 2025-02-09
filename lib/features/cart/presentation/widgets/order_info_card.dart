import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key, required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //label
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightlyGrey,
              fontFamily: "Inter",
            ),
          ),
        ),
        //value
        Expanded(
          child: Text(
            "\$$value",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
              fontFamily: "Inter",
            ),
          ),
        ),
      ],
    );
  }
}
