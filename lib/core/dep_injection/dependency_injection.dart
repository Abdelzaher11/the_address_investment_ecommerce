import 'package:get_it/get_it.dart';
import 'package:the_address_investments_ecommerce/features/cart/data/data_sources/cart_operation_local_data_source.dart';
import 'package:the_address_investments_ecommerce/features/cart/data/data_sources/load_cart_local_data_source._impl.dart';
import 'package:the_address_investments_ecommerce/features/home/data/repositories/home_repo_impl.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/repositories/home_repo.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/use_cases/home_use_case.dart';
import 'package:the_address_investments_ecommerce/features/product_details/data/data_sources/local/add_product_to_cart_local_data_source.dart';
import 'package:the_address_investments_ecommerce/features/product_details/data/data_sources/local/add_product_to_cart_local_data_source_impl.dart';
import 'package:the_address_investments_ecommerce/features/product_details/domain/use_cases/product_details_use_case.dart';

import '../../features/cart/data/data_sources/cart_operation_local_data_source_impl.dart';
import '../../features/cart/data/data_sources/load_cart_local_data_source.dart';
import '../../features/cart/data/repositories/cart_repo_impl.dart';
import '../../features/cart/domain/repositories/cart_repo.dart';
import '../../features/cart/domain/use_cases/cart_use_case.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/data_sources/home_remote_data_source_impl.dart';
import '../../features/product_details/data/data_sources/remote/product_details_remote_data_source.dart';
import '../../features/product_details/data/data_sources/remote/product_details_remote_data_source_impl.dart';
import '../../features/product_details/data/repositories/product_details_repo_impl.dart';
import '../../features/product_details/domain/repositories/product_details_repo.dart';
import '../server/dio/dio.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.I;
  static Future<void> init() async {
    getIt.registerSingleton<DioConnection>(DioConnection());

    //products && categories
    getIt.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(homeRepo: getIt<HomeRepo>()),
    );

    getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(homeRemoteDataSource: getIt<HomeRemoteDataSource>()),
    );

    getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());

    //product details
    getIt.registerLazySingleton<ProductDetailsUseCase>(
      () => ProductDetailsUseCase(productDetailsRepo: getIt<ProductDetailsRepo>()),
    );

    getIt.registerLazySingleton<ProductDetailsRepo>(
      () => ProductDetailsRepoImpl(productDetailsRemoteDataSource: getIt<ProductDetailsRemoteDataSource>(),addProductToCartLocalDataSource: getIt<AddProductToCartLocalDataSource>()),
    );

    getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(() => ProductDetailsRemoteDataSourceImpl());
    getIt.registerLazySingleton<AddProductToCartLocalDataSource>(() => AddProductToCartLocalDataSourceImpl());

    //cart
    getIt.registerLazySingleton<CartUseCase>(
      () => CartUseCase(cartRepo: getIt<CartRepo>()),
    );

    getIt.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(loadCartLocalDataSource: getIt<LoadCartLocalDataSource>(),cartOperationLocalDataSource: getIt<CartOperationLocalDataSource>()),
    );

    getIt.registerLazySingleton<LoadCartLocalDataSource>(() => LoadCartLocalDataSourceImpl());
    getIt.registerLazySingleton<CartOperationLocalDataSource>(() => CartOperationLocalDataSourceImpl());

  }
}
