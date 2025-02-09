// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:the_address_investments_ecommerce/core/errors/exception.dart';
import 'package:the_address_investments_ecommerce/core/errors/failure.dart';
import 'package:the_address_investments_ecommerce/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:the_address_investments_ecommerce/core/models/product_model.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/repositories/home_repo.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/helpers/hive_cache_helper.dart';
import '../models/category_model.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl({required this.homeRemoteDataSource});
  final HomeRemoteDataSource homeRemoteDataSource;
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final List<ProductModel> _result = await homeRemoteDataSource.getProducts();
      List<ProductEntity> _productsEntities = _result
          .map(
            (productModel) => productModel.toEntity(),
          )
          .toList();
       Map<int, ProductEntity> productMap = {};
        for (var product in _productsEntities) {
          productMap[product.id] = product;
        }
        await HiveCacheHelper.addItems<ProductEntity>(HiveBoxes.productsBox, productMap);
      return Right(_productsEntities);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final List<CategoryModel> _result = await homeRemoteDataSource.getCategories();
      List<CategoryEntity> _categoriesEntities = _result
          .map(
            (categoryModel) => categoryModel.toEntity(),
          )
          .toList();
      return Right(_categoriesEntities);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      {required int id, required Map<String, dynamic> updatedProductData}) async {
    try {
      final ProductModel _result = await homeRemoteDataSource.updateProduct(
        id: id,
        updatedProductData: updatedProductData,
      );
      return Right(_result.toEntity());
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
}
