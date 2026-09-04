import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_explorer/features/products/domain/entity/products_entity.dart';

class ProductsPaginationEntity extends Equatable {
  @JsonKey(name: ProductsPaginationKeys.products)
  final List<ProductsEntity> products;
  @JsonKey(name: ProductsPaginationKeys.total)
  final int total;
  @JsonKey(name: ProductsPaginationKeys.skip)
  final int skip;
  @JsonKey(name: ProductsPaginationKeys.limit)
  final int limit;

  const ProductsPaginationEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        products,
        total,
        skip,
        limit,
      ];
}

class ProductsPaginationKeys {
  static const String products = "products";
  static const String total = "total";
  static const String skip = "skip";
  static const String limit = "limit";
}
