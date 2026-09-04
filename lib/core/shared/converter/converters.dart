import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_explorer/features/products/data/model/products_model.dart';
import 'package:store_explorer/features/products/domain/entity/products_entity.dart';

class ProductsConverter extends JsonConverter<ProductsEntity, Map> {
  const ProductsConverter();

  @override
  ProductsEntity fromJson(Map json) =>
      ProductsModel.fromJson(json.cast<String, dynamic>());

  @override
  Map toJson(ProductsEntity object) =>
      ProductsModel.fromEntity(object).toJson();
}