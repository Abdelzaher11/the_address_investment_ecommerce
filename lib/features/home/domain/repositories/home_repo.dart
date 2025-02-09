import 'package:dartz/dartz.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/entities/category_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/entities/product_entity.dart';

abstract class HomeRepo {
    Future<Either<Failure, List<ProductEntity>>> getProducts();
    Future<Either<Failure, List<CategoryEntity>>> getCategories();
    Future<Either<Failure, ProductEntity>> updateProduct({required int id, required Map<String, dynamic> updatedProductData});
}