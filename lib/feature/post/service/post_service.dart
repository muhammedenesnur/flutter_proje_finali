import 'package:dev_template/product/core/base/base_response_model.dart';
import 'package:dev_template/product/core/model/products.dart';
import 'package:dev_template/product/utils/service/iservice_manager.dart';
import 'package:flutter/material.dart';

/// A service class for fetching posts from a remote API.
@immutable
final class ProductsService {
  /// Creates a [PostService] instance.
  const ProductsService(this._serviceManager);
  final IServiceManager<List<dynamic>> _serviceManager;

  final _url = 'https://fakestoreapi.com/products';

  Future<BaseResponseModel<List<Products>>> getProducts() async {
    final response = await _serviceManager.get(_url);
    if (response.data != null) {
      final data = (response.data!)
          .map((item) => Products.fromJson(item as Map<String, dynamic>))
          .toList();
      return BaseResponseModel(data: data);
    } else {
      return BaseResponseModel(error: response.error);
    }
  }
}
