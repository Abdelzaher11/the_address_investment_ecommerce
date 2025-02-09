// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:the_address_investments_ecommerce/core/dep_injection/dependency_injection.dart';
import 'package:the_address_investments_ecommerce/core/endpoints/endpoints.dart';
import 'package:the_address_investments_ecommerce/features/home/data/models/category_model.dart';
import 'package:the_address_investments_ecommerce/core/models/product_model.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/check_internet_access.dart';
import '../../../../core/server/dio/dio.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    bool checkConnection = await CheckInternetAccess.createInstanceAndCheckInternetAccess();
    if (checkConnection) {
      try {
        final Response? _serverResponse = await DependencyInjection.getIt<DioConnection>()
            .get(Endpoints.products,);
        if (_serverResponse?.statusCode == 200 && _serverResponse!.data != null) {
          final _data = _serverResponse.data as List<dynamic>;
          final List<ProductModel> _products =
              _data.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
          _products.removeWhere((product) => product.isEmpty);
          return _products;
        } else {
          throw ErrorHandler.checkStatusCode(_serverResponse!);
        }
      } on DioException catch (exception) {
        throw ErrorHandler.check(exception: exception);
      } catch (e) {
        throw DefaultException();
      }
    } else {
      throw CheckConnectionException();
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    bool checkConnection = await CheckInternetAccess.createInstanceAndCheckInternetAccess();

    if (checkConnection) {
      try {
        final Response? _serverResponse = await DependencyInjection.getIt<DioConnection>().get(Endpoints.categories);

        if (_serverResponse?.statusCode == 200 && _serverResponse!.data != null) {
          final _data = _serverResponse.data as List<dynamic>;
          final List<CategoryModel> _categories =
              _data.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();
          _categories.removeWhere((category) => category.isEmpty);
          return _categories;
        } else {
          throw ErrorHandler.checkStatusCode(_serverResponse!);
        }
      } on DioException catch (exception) {
        throw ErrorHandler.check(exception: exception);
      } catch (e) {
        throw DefaultException();
      }
    } else {
      throw CheckConnectionException();
    }
  }
  
  @override
  Future<ProductModel> updateProduct({required int id, required Map<String, dynamic> updatedProductData}) async {
    bool checkConnection = await CheckInternetAccess.createInstanceAndCheckInternetAccess();
      
    if (checkConnection) {
      try {
        final Response? _serverResponse = await DependencyInjection.getIt<DioConnection>().put("${Endpoints.products}/$id",data: updatedProductData,);
        if (_serverResponse?.statusCode == 200 && _serverResponse!.data != null) {
          final ProductModel _productData = ProductModel.fromJson(_serverResponse.data as Map<String, dynamic>);
          return _productData;
        } else {
          throw ErrorHandler.checkStatusCode(_serverResponse!);
        }
      } on DioException catch (exception) {
         
        throw ErrorHandler.check(exception: exception);
      } catch (e) {
       
        throw DefaultException();
      }
    } else {
      throw CheckConnectionException();
    }
  }
}
