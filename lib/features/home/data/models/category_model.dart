import 'package:the_address_investments_ecommerce/features/home/domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String? name;
  final String image;
  final String creationAt;
  final String updatedAt;
  CategoryModel({required this.id, required this.image, required this.name,required this.creationAt,required this.updatedAt,});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }

  bool get isEmpty => name == null || name == "";

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, image: image, name: name ?? "");
  }
}
