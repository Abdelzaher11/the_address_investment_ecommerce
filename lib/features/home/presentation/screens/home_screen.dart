import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:the_address_investments_ecommerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:the_address_investments_ecommerce/features/home/presentation/widgets/products_list_view.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../widgets/categories_list_view.dart';
import '../widgets/section_title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      buildWhen: (prevoius, current) => current is ProductEditIsOpenedState,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: const CustomAppBar(
                showLogo: true,
                showBackButton: false,
              ),
              body: SingleChildScrollView(
                controller: context.read<HomeBloc>().scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //categories title
                    SectionTitleWidget(
                      title: S.of(context).categories,
                      fontSize: 14.0,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    //categories list
                    BlocBuilder<HomeBloc, HomeStates>(
                      buildWhen: (prevoius, current) =>
                          current is CategoriesSuccessState ||
                          current is CategoriesFailureState ||
                          current is CategoriesLoadingState,
                      builder: (context, state) =>
                          state is CategoriesSuccessState
                              ? const CategoriesListView()
                              : const Skeletonizer(
                                  child: CategoriesListView(
                                  isLoading: true,
                                )),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    //products title
                    SectionTitleWidget(
                      title: S.of(context).products,
                      fontSize: 17.0,
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    //products list
                    BlocBuilder<HomeBloc, HomeStates>(
                      buildWhen: (prevoius, current) =>
                          current is ProductsSuccessState ||
                          current is ProductsFailureState ||
                          current is ProductsLoadingState,
                      builder: (context, state) => state is ProductsSuccessState
                          ? const ProductsListView()
                          : const Skeletonizer(
                              child: ProductsListView(
                              isLoading: true,
                            )),
                    ),
                  ],
                ),
              ),
            ),
            if (context.read<HomeBloc>().isEditing)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
