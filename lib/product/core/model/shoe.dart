import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shoe.g.dart';

@JsonSerializable()
@immutable
final class Shoe with EquatableMixin {
  Shoe({
    this.brand,
    this.size,
    this.price,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) => _$ShoeFromJson(json);
  final String? brand;
  final int? size;
  final int? price;

  Map<String, dynamic> toJson() => _$ShoeToJson(this);

  @override
  List<Object?> get props => [brand, size, price];

  Shoe copyWith({
    String? brand,
    int? size,
    int? price,
  }) {
    return Shoe(
      brand: brand ?? this.brand,
      size: size ?? this.size,
      price: price ?? this.price,
    );
  }
}
