part of 'products_bloc.dart';

@freezed
abstract class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.getAndSearchProducts({
    int? limit,
    String? searchQuery,
    @Default(false) bool isReset,
  }) = _GetProducts;
}
