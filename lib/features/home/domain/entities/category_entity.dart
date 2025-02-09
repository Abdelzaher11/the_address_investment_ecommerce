import 'package:hive_flutter/adapters.dart';

import '../../../../core/utils/hive_types.dart';

part'category_entity.g.dart';
@HiveType(typeId:HiveTypes.categoryTypeID) 
class CategoryEntity extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  CategoryEntity({required this.id,required this.image,required this.name});

  static CategoryEntity empty(){
    return CategoryEntity(id: 0, image: "", name: "");
  }
}