import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/core/navigation/routes.dart';
import 'package:the_address_investments_ecommerce/core/widgets/custom_app_bar.dart';
import 'package:the_address_investments_ecommerce/core/widgets/tap_effect.dart';
import 'package:the_address_investments_ecommerce/features/cart/presentation/widgets/cart_builder.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showActionButton: false,
        title: S.of(context).cart,
        backButtonBackgroundColor: AppColors.lightBackground,
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartStates>(
        buildWhen: (previous, current) =>
            current is CartLoadingState ||
            current is CartSuccessState ||
            current is CartFailureState ||
            current is DeleteProductSuccessState ||
            current is ConfirmOrderLoadingState ||
            current is ConfirmOrderSuccessState,
        builder: (context, state) {
          if (state is CartSuccessState || context.read<CartBloc>().products.isNotEmpty) {
            return TapEffect(
              onClick: () async{
                  await context
                      .read<CartBloc>()
                      .confirmOrder()
                      .then((value) => Navigator.pushNamed(context, AppRoutes.orderConfirmedRoute));
              },
              child: Container(
                alignment: Alignment.center,
                height: 68.h,
                color: AppColors.primary,
                child: state is ConfirmOrderLoadingState
                    ? CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    : Text(
                        S.of(context).checkout,
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
          return const SizedBox.shrink();
        },
      ),
      body: const CartBuilder(),
    );
  }
}
