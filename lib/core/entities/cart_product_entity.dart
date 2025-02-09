import 'package:hive_flutter/adapters.dart';

import '../utils/hive_types.dart';

part 'cart_product_entity.g.dart';

@HiveType(typeId: HiveTypes.cartProductTypeID)
class CartProductEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  int quantity;
  CartProductEntity({required this.id, required this.quantity});
  CartProductEntity copyWith({
    int quantity = 0,
  }) {
    return CartProductEntity(
      id: id,
      quantity: quantity,
    );
  }
  static CartProductEntity empty()=>CartProductEntity(id: 0, quantity: 0);
}
