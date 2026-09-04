// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductsModel', json, ($checkedConvert) {
      final val = ProductsModel(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        title: $checkedConvert('title', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
        category: $checkedConvert('category', (v) => v as String),
        price: $checkedConvert('price', (v) => (v as num).toDouble()),
        discountPercentage: $checkedConvert(
          'discountPercentage',
          (v) => (v as num).toDouble(),
        ),
        rating: $checkedConvert('rating', (v) => (v as num).toDouble()),
        stock: $checkedConvert('stock', (v) => (v as num).toInt()),
        brand: $checkedConvert('brand', (v) => v as String?),
        images: $checkedConvert(
          'images',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
        ),
        thumbnail: $checkedConvert('thumbnail', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'brand': instance.brand,
      'images': instance.images,
      'thumbnail': instance.thumbnail,
    };
