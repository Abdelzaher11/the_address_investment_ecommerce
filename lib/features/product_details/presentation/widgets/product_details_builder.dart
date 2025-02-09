import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/widgets/add_to_cart_button.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/widgets/description_text.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/widgets/product_main_image.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/widgets/product_title_and_price.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../bloc/product_details_bloc.dart';

class ProductDetailsBuilder extends StatelessWidget {
  const ProductDetailsBuilder({super.key, this.isLoading = false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(backgroundColor: Colors.transparent,),
      bottomNavigationBar: AddToCartButton(
        isLoading: isLoading,
        product: context.read<ProductDetailsBloc>().product,
        productDetailsBloc: context.read<ProductDetailsBloc>(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            ProductMainImage(
              isLoading: isLoading,
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title & price
                  ProductTitleAndPrice(
                    isLoading: isLoading,
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  //images
                  SizedBox(
                    height: 77.h,
                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: isLoading ? 4 : context.read<ProductDetailsBloc>().product.images.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 9.w,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (isLoading) {
                          return Skeletonizer(
                            child: Container(
                              height: 77.r,
                              width: 77.r,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              alignment: Alignment.center,
                              child: const CachedNetworkImageWidget(
                                image: "",
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 77.r,
                          width: 77.r,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.center,
                          child: CachedNetworkImageWidget(
                            image: context.read<ProductDetailsBloc>().product.images[index],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //description & see more
                  Text(
                    S.of(context).description,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ExpandableText(
                    text:
                        context.read<ProductDetailsBloc>().product.description,
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
