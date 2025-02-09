import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:the_address_investments_ecommerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:the_address_investments_ecommerce/features/home/presentation/widgets/category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key,this.isLoading=false});
  final bool isLoading;
  @override

  Widget build(BuildContext context) {
    return SizedBox(
      height: 94.h,
      width: double.infinity,
      child: ListView.separated(
        itemCount: isLoading?11:context.read<HomeBloc>().categories.length,
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 24.w,
          );
        },
        itemBuilder: (context, index) {
          return CategoriesCard(category: isLoading?CategoryEntity.empty():context.read<HomeBloc>().categories[index],);
        },
      ),
    );
  }
}
