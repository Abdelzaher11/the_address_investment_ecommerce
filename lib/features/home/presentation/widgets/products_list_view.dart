import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/features/home/presentation/widgets/product_card.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_colors.dart';
import '../bloc/home_bloc.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key, this.isLoading = false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //products
        BlocBuilder<HomeBloc, HomeStates>(
          bloc: context.read<HomeBloc>(),
          buildWhen: (prevoius,current)=> current is PaginationFinishedState,
          builder: (context, state) {
            return GridView.builder(
              itemCount: isLoading ? 11 : context.read<HomeBloc>().productsScreenList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                return BlocBuilder<HomeBloc, HomeStates>(
                  buildWhen: (prevoius, current) => (current is UpdateProductSuccessState &&
                      current.id == context.read<HomeBloc>().productsScreenList[index].id),
                  builder: (context, state) => ProductCard(
                    product: isLoading ? ProductEntity.empty() : context.read<HomeBloc>().productsScreenList[index],
                  ),
                );
                // return ProductCard(product:isLoading?ProductEntity.empty():context.read<HomeBloc>().products[index],);
              },
            );
          },
        ),
        BlocBuilder(
          bloc: context.read<HomeBloc>(),
          buildWhen: (prevoius, current) => current is PaginationLoadingState || current is PaginationFinishedState,
          builder: (context, state) => state is PaginationLoadingState
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: 10.r),
                child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
              )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
