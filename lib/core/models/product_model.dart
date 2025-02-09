import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';

import '../../features/home/domain/entities/category_entity.dart';
import '../../features/home/data/models/category_model.dart';

class ProductModel {
  final int id;
  final String? title;
  final String? description;
  final int price;
  final CategoryModel? category;
  final List<String>? images;
  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.category,
      required this.images});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toInt(),
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  bool get isEmpty => title == null || title == "" || price == 0;

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title ?? "",
      description: description ?? "",
      price: price,
      category: category?.toEntity() ?? CategoryEntity.empty(),
      images: images ?? [],
    );
  }
}
