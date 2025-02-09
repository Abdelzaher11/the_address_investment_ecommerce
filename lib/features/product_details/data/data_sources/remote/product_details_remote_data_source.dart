import '../../../../../core/models/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductModel> getProductDetails({required int id});
} 