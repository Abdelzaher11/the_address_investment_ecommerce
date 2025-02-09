import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/entities/category_entity.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key, required this.category});
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94.h,
      width: 72.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image
          Container(
            height: 72.r,
            width: 72.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkGrey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: CachedNetworkImageWidget(
                image: category.image,
              ),
            ),
          ),
          // SizedBox(height: 8.h,),
          //label
          Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Inter",
            ),
          ),
        ],
      ),
    );
  }
}
