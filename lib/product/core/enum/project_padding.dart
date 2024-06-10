import 'package:flutter/material.dart';

/// Project Padding
enum ProjectPadding {
  /// Low padding 8 px
  low._(8),

  /// Medium padding 16 px
  medium._(16),

  /// High padding 24 px
  high._(24);

  /// Padding value
  final double _value;

  /// Constructor
  // ignore: sort_constructors_first
  const ProjectPadding._(this._value);

  /// Padding all
  EdgeInsets get paddingAll => EdgeInsets.all(_value);

  /// Padding horizontal
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: _value);

  /// Padding vertical
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: _value);

  /// Padding only Left
  EdgeInsetsGeometry get paddingOnlyLeft => EdgeInsets.only(left: _value);

  /// Padding only right
  EdgeInsetsGeometry get paddingOnlyRight => EdgeInsets.only(right: _value);

  /// Padding only top
  EdgeInsetsGeometry get paddingOnlyTop => EdgeInsets.only(top: _value);

  /// Padding only bottom
  EdgeInsetsGeometry get paddingOnlyBottom => EdgeInsets.only(bottom: _value);
}
