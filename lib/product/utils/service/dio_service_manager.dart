import 'dart:io';

import 'package:dev_template/product/core/base/base_request_model.dart';
import 'package:dev_template/product/core/base/base_response_model.dart';
import 'package:dev_template/product/utils/service/iservice_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// A class that manages Dio service for making HTTP requests.
@immutable
final class DioServiceManager<T> implements IServiceManager<T> {
  /// Creates a DioServiceManager.
  DioServiceManager() {
    _dio = Dio();
  }

  late final Dio _dio;

  @override
  Future<BaseResponseModel<T>> get(String url) async {
    try {
      final response = await _dio.get<T>(url);
      if (response.statusCode == HttpStatus.ok) {
        return BaseResponseModel<T>(data: response.data);
      } else {
        return BaseResponseModel<T>(error: 'Failed to load data');
      }
    } on DioException catch (e) {
      return BaseResponseModel<T>(error: e.message);
    }
  }

  @override
  Future<BaseResponseModel<T>> post({
    required String url,
    BaseRequestModel? data,
  }) async {
    try {
      final response = await _dio.post<T>(
        url,
        data: data,
      );
      if (response.statusCode == HttpStatus.ok) {
        return BaseResponseModel<T>(data: response.data);
      } else {
        return BaseResponseModel<T>(error: 'Failed to load data');
      }
    } on DioException catch (e) {
      return BaseResponseModel<T>(error: e.message);
    }
  }
}
