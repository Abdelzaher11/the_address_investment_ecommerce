import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/features/cart/presentation/widgets/cart_list_view_builder.dart';
import 'package:the_address_investments_ecommerce/features/cart/presentation/widgets/payment_method_builder.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../bloc/cart_bloc.dart';
import 'order_info_builder.dart';

class CartBuilder extends StatelessWidget {
  const CartBuilder({super.key, this.isLoading = false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.r,
          right: 20.r,
          bottom: 20.r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            //products list
            BlocConsumer<CartBloc, CartStates>(
              buildWhen: (previous, current) =>
                  current is CartLoadingState ||
                  current is CartSuccessState ||
                  current is CartFailureState ||
                  current is DeleteProductSuccessState||
                  current is CartProductOperationSuccessState,
              listener: (context, state) {
                if (state is DeleteProductSuccessState) {
                  context.read<CartBloc>().products = state.currentProductsList;
                  context.read<CartBloc>().cartProducts = state.currentCartList;
                }
              },
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return const CartListViewBuilder(
                    isLoading: true,
                    cartProducts: [],
                    products: [],
                  );
                } else if (context.read<CartBloc>().products.isEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_shopping_cart_rounded,
                          color: AppColors.primary,
                          size: 100.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          S.of(context).emptyCart,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return CartListViewBuilder(
                  products: context.read<CartBloc>().products,
                  cartProducts: context.read<CartBloc>().cartProducts,
                );
              },
            ),
            SizedBox(
              height: 32.h,
            ),
            //payment method
            BlocBuilder<CartBloc, CartStates>(
              buildWhen: (previous, current) =>
                  current is CartLoadingState || current is CartSuccessState || current is CartFailureState || current is DeleteProductSuccessState,
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return const PaymentMethodBuilder(
                    isLoading: true,
                  );
                } else if (context.read<CartBloc>().products.isEmpty) {
                  return const SizedBox.shrink();
                }
                return const PaymentMethodBuilder();
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            //order info
            BlocBuilder<CartBloc, CartStates>(
              buildWhen: (previous, current) =>
                  current is CartLoadingState ||
                  current is CartSuccessState ||
                  current is CartFailureState ||
                  current is DeleteProductSuccessState ||
                  current is CartProductOperationSuccessState,
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return OrderInfoBuilder(
                    isLoading: true,
                    subTotal: context.read<CartBloc>().subTotal,
                    total: context.read<CartBloc>().total,
                  );
                } else if (context.read<CartBloc>().products.isEmpty) {
                  return const SizedBox.shrink();
                }
                return OrderInfoBuilder(
                  subTotal: context.read<CartBloc>().subTotal,
                  total: context.read<CartBloc>().total,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
