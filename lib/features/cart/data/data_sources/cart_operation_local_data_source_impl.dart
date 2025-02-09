// ignore_for_file: no_leading_underscores_for_local_identifiers

import '../../../../core/entities/cart_product_entity.dart';
import '../../../../core/helpers/hive_cache_helper.dart';
import 'cart_operation_local_data_source.dart';

class CartOperationLocalDataSourceImpl implements CartOperationLocalDataSource {
  @override
  Future<CartProductEntity> decrementProductQuantity({required int productId}) async {
    CartProductEntity? product = await HiveCacheHelper.getItem<CartProductEntity>(HiveBoxes.cartBox, productId);
    if (product != null && product.quantity > 1) {
      await HiveCacheHelper.updateField<CartProductEntity>(
        HiveBoxes.cartBox,
        productId,
        (item) async {
          final _newItem = item.copyWith(quantity: item.quantity - 1);
          await HiveCacheHelper.addItem(HiveBoxes.cartBox, productId, _newItem);
        },
      );
      return (await HiveCacheHelper.getItem<CartProductEntity>(HiveBoxes.cartBox, productId)) ??
          CartProductEntity.empty();
    } else {
      await deleteProduct(productId: productId);
      return CartProductEntity.empty();
    }
  }

  @override
  Future<void> deleteProduct({required int productId}) async {
    await HiveCacheHelper.deleteItem<CartProductEntity>(HiveBoxes.cartBox, productId);
  }

  @override
  Future<CartProductEntity> incrementProductQuantity({required int productId}) async {
    await HiveCacheHelper.updateField<CartProductEntity>(
      HiveBoxes.cartBox,
      productId,
      (item) async {
        final _newItem = item.copyWith(quantity: item.quantity + 1);
        await HiveCacheHelper.addItem(HiveBoxes.cartBox, productId, _newItem);
      },
    );
    return (await HiveCacheHelper.getItem<CartProductEntity>(HiveBoxes.cartBox, productId)) ??
          CartProductEntity.empty();
  }
}
