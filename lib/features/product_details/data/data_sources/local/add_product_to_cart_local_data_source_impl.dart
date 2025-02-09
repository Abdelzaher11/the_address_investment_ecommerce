// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:the_address_investments_ecommerce/core/entities/cart_product_entity.dart';

import '../../../../../core/helpers/hive_cache_helper.dart';
import 'add_product_to_cart_local_data_source.dart';

class AddProductToCartLocalDataSourceImpl implements AddProductToCartLocalDataSource {
  @override
  Future<void> addProductToCart({required int productId}) async {
    CartProductEntity? productExist = await HiveCacheHelper.getItem<CartProductEntity>(HiveBoxes.cartBox, productId);
    if (productExist != null) {
      await HiveCacheHelper.updateField<CartProductEntity>(
        HiveBoxes.cartBox,
        productId,
        (item) async {
          final _newItem = item.copyWith(quantity: item.quantity + 1);
          await HiveCacheHelper.addItem(HiveBoxes.cartBox, productId, _newItem);
        },
      );
    } else {
      await HiveCacheHelper.addItem<CartProductEntity>(
        HiveBoxes.cartBox,
        productId,
        CartProductEntity(
          id: productId,
          quantity: 1,
        ),
      );
    }
  }
}
