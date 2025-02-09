import 'package:hive_flutter/adapters.dart';

import '../../features/home/domain/entities/category_entity.dart';
import '../utils/hive_types.dart';

part'product_entity.g.dart';

@HiveType(typeId: HiveTypes.productTypeID)
class ProductEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final CategoryEntity category;
  @HiveField(5)
  final List<String> images;
  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
  });
  static ProductEntity empty() {
    return ProductEntity(
      id: 0,
      title: "",
      description: "",
      price: 0,
      category: CategoryEntity.empty(),
      images: [],
    );
  }
}
