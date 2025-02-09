
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_address_investments_ecommerce/core/dep_injection/dependency_injection.dart';
import 'package:the_address_investments_ecommerce/core/helpers/hive_cache_helper.dart';

import 'app/app.dart';
import 'core/entities/cart_product_entity.dart';
import 'core/entities/product_entity.dart';
import 'features/home/domain/entities/category_entity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(CartProductEntityAdapter());
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(CategoryEntityAdapter());
  await HiveCacheHelper.openBox<CartProductEntity>(HiveBoxes.cartBox);
  await HiveCacheHelper.openBox<ProductEntity>(HiveBoxes.productsBox);
  await DependencyInjection.init();
  runApp(const LazaApp());
}
