part of 'products_bloc.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(false) bool productsLoading,
    @Default(false) bool isPaginationLoading,
    @Default([]) List<ProductsEntity> products,
    @Default(0) int total,
    @Default(true) bool hasMore,
    String? currentQuery,
    Failure? failure,
  }) = _ProductsState;
}
