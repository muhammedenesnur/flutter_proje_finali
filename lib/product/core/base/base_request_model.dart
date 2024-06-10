import 'package:flutter/material.dart';

/// A class representing the base request model.
@immutable
final class BaseRequestModel {
  /// Creates a new instance of [BaseRequestModel].
  const BaseRequestModel({
    required this.data,
  });

  /// The data of the request.
  final Map<String, dynamic> data;
}
