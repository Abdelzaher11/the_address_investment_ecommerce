import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';

class PaymentMethodBuilder extends StatelessWidget {
  const PaymentMethodBuilder({super.key,this.isLoading=false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Skeletonizer(child: PaymentMethodWidget());
    }
    return const PaymentMethodWidget();
  }
}


class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).paymentMethod,
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
          ),
        ),
        SizedBox(height: 15.h),
        //cash on delivery
        Container(
          height: 50.h,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.lightBackground,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.only(
            left: 16.r,
            right: 12.r,
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              //title
              Expanded(
                child: Text(
                  S.of(context).cod,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.lightBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              //icon
              Container(
                height: 25.r,
                width: 25.r,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Color(0xff4AC76D), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 15.r,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        //order info
        Text(
          S.of(context).orderInfo,
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
          ),
        )
      ],
    );
  }
}