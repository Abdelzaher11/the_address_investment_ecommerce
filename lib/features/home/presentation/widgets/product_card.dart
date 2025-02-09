import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/core/widgets/cached_network_image_widget.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/bottom_sheet.dart';
import '../bloc/home_bloc.dart';
import 'update_product_sheet.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productDetailsRoute, arguments: product.id);
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              height: 203.h,
              width: 160.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.lightBackground, 
                
              ),
              alignment: AlignmentDirectional.topEnd,
  
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  //image
                  SizedBox(
                        height: 203.h,
                        width: 160.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImageWidget(
                          image: product.images.isNotEmpty ? product.images.first : "",
                          fit: BoxFit.fill,
                          
                        ),
                      )),
                  //edit icon
                  Padding(
                    padding:  EdgeInsets.all(8.h),
                    child: InkWell(
                      onTap: () {
                        context.read<HomeBloc>().openEdit();
                        CustomBottomSheet.showSheet(
                          widget: UpdateproductSheet(productEntity: product,homeBloc: context.read<HomeBloc>(),),
                          context: context,
                          whenCmplete: () => context.read<HomeBloc>().openEdit(),
                        );
                      },
                      child: Image.asset(
                        AppAssets.editIcon,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            //title
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                height: 1.1,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            //price
            Text(
              "\$${product.price}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
