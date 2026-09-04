import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ProductDetailsEntity extends Equatable {
  @JsonKey(name: ProductDetailsKeys.id)
  final int id;
  @JsonKey(name: ProductDetailsKeys.title)
  final String title;
  @JsonKey(name: ProductDetailsKeys.description)
  final String description;
  @JsonKey(name: ProductDetailsKeys.category)
  final String category;
  @JsonKey(name: ProductDetailsKeys.price)
  final double price;
  @JsonKey(name: ProductDetailsKeys.discountPercentage)
  final double discountPercentage;
  @JsonKey(name: ProductDetailsKeys.rating)
  final double rating;
  @JsonKey(name: ProductDetailsKeys.stock)
  final int stock;
  @JsonKey(name: ProductDetailsKeys.brand)
  final String? brand;
  @JsonKey(name: ProductDetailsKeys.availabilityStatus)
  final String? availabilityStatus;
  @JsonKey(name: ProductDetailsKeys.images)
  final List<String> images;
  @JsonKey(name: ProductDetailsKeys.thumbnail)
  final String? thumbnail;

  const ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    this.category = '',
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.brand,
    this.availabilityStatus,
    this.images = const [],
    this.thumbnail,
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
        availabilityStatus,
        images,
        thumbnail,
      ];
}

class ProductDetailsKeys {
  static const String id = "id";
  static const String title = "title";
  static const String description = "description";
  static const String category = "category";
  static const String price = "price";
  static const String discountPercentage = "discountPercentage";
  static const String rating = "rating";
  static const String stock = "stock";
  static const String brand = "brand";
  static const String availabilityStatus = "availabilityStatus";
  static const String images = "images";
  static const String thumbnail = "thumbnail";
}

