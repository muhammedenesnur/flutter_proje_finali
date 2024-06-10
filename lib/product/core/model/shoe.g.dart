// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shoe _$ShoeFromJson(Map<String, dynamic> json) => Shoe(
      brand: json['brand'] as String?,
      size: (json['size'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShoeToJson(Shoe instance) => <String, dynamic>{
      'brand': instance.brand,
      'size': instance.size,
      'price': instance.price,
    };
