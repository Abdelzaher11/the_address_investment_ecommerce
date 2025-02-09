import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address_investments_ecommerce/features/product_details/presentation/widgets/product_details_builder.dart';

import '../../../../core/dep_injection/dependency_injection.dart';
import '../../domain/use_cases/product_details_use_case.dart';
import '../bloc/product_details_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final int productId = ModalRoute.of(context)?.settings.arguments as int? ?? 0;

    return BlocProvider(
      create: (context) => ProductDetailsBloc(productDetailsUseCase: DependencyInjection.getIt.get<ProductDetailsUseCase>(),)..loadProductDetails(id: productId,),
      child: BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
        buildWhen: (prevoius, current) =>
            current is ProductLoadingState || current is ProductSuccessState || current is ProductFailureState,
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const ProductDetailsBuilder(
              isLoading: true,
            );
          }
          return const ProductDetailsBuilder();
        },
      ),
    );
  }
}
