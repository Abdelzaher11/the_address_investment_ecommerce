// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/core/widgets/cached_network_image_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../bloc/cart_bloc.dart';

class ProductWideCard extends StatelessWidget {
  ProductWideCard({super.key, required this.product, required this.quantity});
  final ProductEntity product;
  int quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 24.0,
            spreadRadius: 0.0,
            color: const Color(0xff000000).withOpacity(0.09),
            offset: const Offset(0.0, 0.0),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.r),
      child: Row(
        children: [
          //image
          Container(
            height: 100.r,
            width: 100.r,
            alignment: Alignment.center,
            child: CachedNetworkImageWidget(
              image: product.images.isNotEmpty ? product.images.first : "",
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          //product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //title
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //price
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                    color: AppColors.lightlyGrey,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                //counters & delete button
                Row(
                  children: [
                    //counters
                    Row(
                      children: [
                        //minus
                        InkWell(
                          onTap: () async => await context
                              .read<CartBloc>()
                              .decrementQuantity(productID: product.id),
                          child: Container(
                            height: 25.r,
                            width: 25.r,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                              border:
                                  Border.all(color: AppColors.grey, width: 1.w),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        //count
                        Text(
                          "$quantity",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightBlack,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        //plus
                        InkWell(
                          onTap: () async => await context
                              .read<CartBloc>()
                              .incrementQuantity(productID: product.id),
                          child: Container(
                            height: 25.r,
                            width: 25.r,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                              border:
                                  Border.all(color: AppColors.grey, width: 1.w),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    //delete button
                    InkWell(
                      onTap: () async => await context
                          .read<CartBloc>()
                          .deleteProduct(productID: product.id),
                      child: Container(
                        height: 25.r,
                        width: 25.r,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          border: Border.all(color: AppColors.grey, width: 1.w),
                        ),
                        child: Icon(
                          Icons.delete_outlined,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
