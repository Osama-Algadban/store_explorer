part of 'products_details_bloc.dart';

@freezed
abstract class ProductsDetailsState with _$ProductsDetailsState {
  const factory ProductsDetailsState({
    @Default(false) bool productsDetailsLoading,
    ProductDetailsEntity? productDetails,
    Failure? failure,
  }) = _ProductsDetailsState;

  
}