import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_explorer/core/shared/converter/converters.dart';
import 'package:store_explorer/core/shared/models/base_model.dart';
import 'package:store_explorer/features/products/domain/entity/products_pagination_entity.dart';

part 'products_pagination_model.g.dart';

@JsonSerializable(
  checked: true,
  converters: [
    ProductsConverter(),
  ],
)
class ProductsPaginationModel extends ProductsPaginationEntity implements Model {
  const ProductsPaginationModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductsPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsPaginationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductsPaginationModelToJson(this);
}
