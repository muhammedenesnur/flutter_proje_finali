import 'package:dev_template/product/core/base/base_request_model.dart';
import 'package:dev_template/product/core/base/base_response_model.dart';
import 'package:flutter/material.dart';

/// The interface for a service manager that handles API requests and responses.
///
/// This interface provides a method to send a GET request to the specified URL
/// and returns a [BaseResponseModel] containing the response data of type [T].
@immutable
abstract interface class IServiceManager<T> {
  /// Sends a GET request to the specified URL and returns the response data.
  ///
  /// The [url] parameter specifies the URL to send the request to.
  /// Returns a [Future] that completes with a [BaseResponseModel] containing
  /// the response data of type [T].
  Future<BaseResponseModel<T>> get(String url);

  /// Sends a POST request to the specified URL and returns the response data.
  Future<BaseResponseModel<T>> post({
    required String url,
    BaseRequestModel? data,
  });
}
