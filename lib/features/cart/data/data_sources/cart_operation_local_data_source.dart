import 'package:the_address_investments_ecommerce/core/entities/cart_product_entity.dart';

abstract class CartOperationLocalDataSource {
  Future<CartProductEntity> incrementProductQuantity({required int productId});
  Future<CartProductEntity> decrementProductQuantity({required int productId});
  Future<void> deleteProduct({required int productId});
}
