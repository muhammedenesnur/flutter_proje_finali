import 'package:flutter/material.dart';

/// A generic class representing the base response model.
@immutable
final class BaseResponseModel<T> {
  /// Creates a new instance of [BaseResponseModel].
  const BaseResponseModel({
    this.data,
    this.error,
  });

  /// The data of the response.
  final T? data;

  /// The error message, if any.
  final String? error;
}
