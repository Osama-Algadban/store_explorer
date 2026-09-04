import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_explorer/core/shared/models/base_model.dart';
import 'package:store_explorer/features/products_details/domain/entity/product_details_entity.dart';

part 'product_details_model.g.dart';

@JsonSerializable(checked: true)
class ProductDetailsModel extends ProductDetailsEntity implements Model {
  const ProductDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    super.category = '',
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    super.brand,
    super.availabilityStatus,
    super.images = const [],
    super.thumbnail,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);

  factory ProductDetailsModel.fromEntity(ProductDetailsEntity entity) {
    return ProductDetailsModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      discountPercentage: entity.discountPercentage,
      rating: entity.rating,
      stock: entity.stock,
      brand: entity.brand,
      availabilityStatus: entity.availabilityStatus,
      images: entity.images,
      thumbnail: entity.thumbnail,
    );
  }
}

