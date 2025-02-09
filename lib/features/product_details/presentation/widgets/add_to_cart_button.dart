import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:the_address_investments_ecommerce/core/widgets/tap_effect.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/bloc/product_details_bloc.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/toast.dart';
import '../../../../generated/l10n.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, this.isLoading = false, required this.productDetailsBloc,required this.product});
  final bool isLoading;
  final ProductDetailsBloc productDetailsBloc;
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return TapEffect(
        onClick: (){

        },
        child: Container(
          alignment: Alignment.center,
            height: 68.h,
            // onPressed: () {},
            // elevation: 0,
            color: AppColors.primary,
            child: Text(
              S.of(context).addToCart,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontFamily: "Inter",
              ),
            ),
          ),
      
      );
    }

    return BlocConsumer<ProductDetailsBloc, ProductDetailsStates>(
      bloc: productDetailsBloc,
      buildWhen: (prevoius,current)=>current is AddProductToCartLoadingState || current is AddProductToCartSuccessState || current is AddProductToCartFailureState,
      listener: (context, state) {
         if (state is AddProductToCartSuccessState) {
                CustomToast.showToast(
                  background: Colors.green,
                  msg: S.of(context).productAddedToCartSuccessfully,
                );
              }
              if (state is AddProductToCartFailureState) {
                CustomToast.showToast(
                  msg: state.message,
                  background: Colors.red,
                );
              }
      },
      builder: (context, state) {
        return MaterialButton(
          height: 68.h,
          onPressed: () async {
            await productDetailsBloc.addProductToCart(productId: product.id);
          },
          elevation: 0,
          color: AppColors.primary,
          child: state is AddProductToCartLoadingState? CircularProgressIndicator(color: AppColors.white,):Text(
            S.of(context).addToCart,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontFamily: "Inter",
            ),
          ),
        );
      },
    );
  }
}
