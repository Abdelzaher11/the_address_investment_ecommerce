import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address_investments_ecommerce/core/dep_injection/dependency_injection.dart';
import 'package:the_address_investments_ecommerce/features/home/presentation/bloc/home_bloc.dart';

import '../../features/cart/domain/use_cases/cart_use_case.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/home/domain/use_cases/home_use_case.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/order_confirmed/presentation/screens/order_confirmed_screen.dart';
import '../../features/product_details/presentation/screens/product_details_screen.dart';

class AppRoutes {
  static const String initialRoute = homeRoute;

  static const String homeRoute = '/home';
  static const String productDetailsRoute = '/product_details';
  static const String cartRoute = '/cart';
  static const String orderConfirmedRoute = '/OrderConfirmedScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRoute: (context) => BlocProvider(
          create: (context) => HomeBloc(homeUseCase: DependencyInjection.getIt.get<HomeUseCase>())..init(),
          child: const HomeScreen(),
        ),
    productDetailsRoute: (context) => const ProductDetailsScreen(),
    orderConfirmedRoute: (context) => const OrderConfirmedScreen(),
    cartRoute: (context) => BlocProvider(
          create: (context) => CartBloc(cartUseCase: DependencyInjection.getIt.get<CartUseCase>())..init(),
          child: const CartScreen(),
        ),
  };
}
