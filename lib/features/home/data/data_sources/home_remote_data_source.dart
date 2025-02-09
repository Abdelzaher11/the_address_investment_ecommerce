import 'package:the_address_investments_ecommerce/core/models/product_model.dart';

import '../models/category_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
  Future<ProductModel> updateProduct({required int id,required Map<String,dynamic> updatedProductData});
}