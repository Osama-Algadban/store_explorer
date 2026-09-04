part of 'products_details_bloc.dart';

@freezed
abstract class ProductsDetailsEvent with _$ProductsDetailsEvent {
  const factory ProductsDetailsEvent.getProductsDetails(int productId) = _GetProductsDetails;
}
