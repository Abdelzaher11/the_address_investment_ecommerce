import '../../../../core/entities/cart_product_entity.dart';

abstract class LoadCartLocalDataSource{
  Future<List<CartProductEntity>> getCartProducts();
}