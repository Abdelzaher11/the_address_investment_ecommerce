import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/features/cart/presentation/widgets/product_wide_card.dart';

import '../../../../core/entities/cart_product_entity.dart';
import '../bloc/cart_bloc.dart';

class CartListViewBuilder extends StatelessWidget {
  const CartListViewBuilder({super.key, this.isLoading = false,required this.cartProducts,required this.products});
  final bool isLoading;
  final List<ProductEntity> products;
  final List<CartProductEntity> cartProducts;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer(
        child: ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          itemBuilder: (context, index) {
            return ProductWideCard(
              product: ProductEntity.empty(),
              quantity: 0,
            );
          },
        ),
      );
    }
    return ListView.separated(
      itemCount: products.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 16.h,
        );
      },
      itemBuilder: (context, index) {
        return BlocBuilder<CartBloc, CartStates>(
          buildWhen: (prevoius, current) => current is CartProductOperationSuccessState && current.productId == products[index].id,
          builder: (context, state) {
            return ProductWideCard(
              product: products[index],
              quantity: cartProducts[index].quantity,
            );
          },
        );
      },
    );
  }
}
