import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_explorer/core/shared/models/base_model.dart';
import 'package:store_explorer/features/products/domain/entity/products_entity.dart';

part 'products_model.g.dart';



@JsonSerializable(checked: true)
class ProductsModel extends ProductsEntity implements Model {
  const ProductsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    super.brand,
    super.images = const [],
    required super.thumbnail,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);

  factory ProductsModel.fromEntity(ProductsEntity entity) {
    return ProductsModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      discountPercentage: entity.discountPercentage,
      rating: entity.rating,
      stock: entity.stock,
      brand: entity.brand,
      images: entity.images,
      thumbnail: entity.thumbnail,
    );
  }
}
