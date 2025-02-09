import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/bloc/product_details_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';

class ProductTitleAndPrice extends StatelessWidget {
  const ProductTitleAndPrice({super.key, this.isLoading = false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Men's Printed Pullover Hoodie",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          color: AppColors.lightlyGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).price,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          color: AppColors.lightlyGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nike Club Fleece",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$120",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        //category name & price
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<ProductDetailsBloc>().product.category.name,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      color: AppColors.lightlyGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).price,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      color: AppColors.lightlyGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        //product name & price value
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<ProductDetailsBloc>().product.title,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${context.read<ProductDetailsBloc>().product.price}",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
