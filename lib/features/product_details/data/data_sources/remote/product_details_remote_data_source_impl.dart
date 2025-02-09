// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:the_address_investments_ecommerce/core/models/product_model.dart';

import '../../../../../core/dep_injection/dependency_injection.dart';
import '../../../../../core/endpoints/endpoints.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exception.dart';
import '../../../../../core/network/check_internet_access.dart';
import '../../../../../core/server/dio/dio.dart';
import 'product_details_remote_data_source.dart';

class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSource{
  @override
  Future<ProductModel> getProductDetails({required int id}) async {
      bool checkConnection = await CheckInternetAccess.createInstanceAndCheckInternetAccess();
      
    if (checkConnection) {
      try {
        final Response? _serverResponse = await DependencyInjection.getIt<DioConnection>().get("${Endpoints.products}/$id");
       
        if (_serverResponse?.statusCode == 200 && _serverResponse!.data != null) {
          final _data = _serverResponse.data as Map<dynamic,dynamic>;
          final ProductModel _productData = ProductModel.fromJson(_data as Map<String, dynamic>);
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