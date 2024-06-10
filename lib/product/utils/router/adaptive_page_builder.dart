import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final class AdaptivePageBuilder {
  AdaptivePageBuilder._();

  /// [builder] metodu, platforma göre sayfa builder'ı döndürür.
  static Page<T> builder<T>({
    required Widget child,
  }) {
    if (Platform.isIOS) {
      return CupertinoPage<T>(
        child: child,
      );
    }
    return MaterialPage<T>(
      child: child,
    );
  }
}
