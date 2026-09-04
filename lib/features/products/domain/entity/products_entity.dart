import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ProductsEntity extends Equatable {
  @JsonKey(name: ProductsKeys.id)
  final int id;
  @JsonKey(name: ProductsKeys.title)
  final String title;
  @JsonKey(name: ProductsKeys.description)
  final String description;
  @JsonKey(name: ProductsKeys.category)
  final String category;
  @JsonKey(name: ProductsKeys.price)
  final double price;
  @JsonKey(name: ProductsKeys.discountPercentage)
  final double discountPercentage;
  @JsonKey(name: ProductsKeys.rating)
  final double rating;
  @JsonKey(name: ProductsKeys.stock)
  final int stock;
  @JsonKey(name: ProductsKeys.brand)
  final String? brand;
  @JsonKey(name: ProductsKeys.images)
  final List<String> images;
  @JsonKey(name: ProductsKeys.thumbnail)
  final String thumbnail;

  const ProductsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.brand,
    this.images = const [],
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        images,
        thumbnail,
      ];
}

class ProductsKeys {
  static const String id = "id";
  static const String title = "title";
  static const String description = "description";
  static const String category = "category";
  static const String price = "price";
  static const String discountPercentage = "discountPercentage";
  static const String rating = "rating";
  static const String stock = "stock";
  static const String brand = "brand";
  static const String images = "images";
  static const String thumbnail = "thumbnail";
}
