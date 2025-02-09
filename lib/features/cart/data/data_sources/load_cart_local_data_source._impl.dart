import 'package:the_address_investments_ecommerce/core/entities/cart_product_entity.dart';

import '../../../../core/helpers/hive_cache_helper.dart';
import 'load_cart_local_data_source.dart';

class LoadCartLocalDataSourceImpl implements LoadCartLocalDataSource{
  @override
  Future<List<CartProductEntity>> getCartProducts() async => await HiveCacheHelper.getItems<CartProductEntity>(HiveBoxes.cartBox);
}