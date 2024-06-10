import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'image_model.g.dart';

@HiveType(typeId: 1)
final class ImageModel extends Equatable {
  ImageModel({
    required this.path,
    String? id,
  }) : id = id ?? UniqueKey().toString();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String path;

  @override
  List<Object> get props => [id, path];

  /// cOPY WITH
  ImageModel copyWith({
    String? id,
    String? path,
  }) {
    return ImageModel(
      id: id ?? this.id,
      path: path ?? this.path,
    );
  }
}
