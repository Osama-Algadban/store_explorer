import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products_details/domain/entity/product_details_entity.dart';
import 'package:store_explorer/features/products_details/domain/use_cases/product_details_use_cases.dart';

part 'products_details_event.dart';
part 'products_details_state.dart';
part 'products_details_bloc.freezed.dart';

@injectable
class ProductsDetailsBloc extends Bloc<ProductsDetailsEvent, ProductsDetailsState> {
  final ProductDetailsUseCases productDetailsUseCases;

  ProductsDetailsBloc(this.productDetailsUseCases) : super(const ProductsDetailsState()) {
    on<_GetProductsDetails>(_getProductsDetails);
  }

  FutureOr<void> _getProductsDetails(
    _GetProductsDetails event,
    Emitter<ProductsDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        productsDetailsLoading: true,
        failure: null,
      ),
    );

    final result = await productDetailsUseCases.getProductDetails(event.productId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          productsDetailsLoading: false,
          failure: failure,
        ),
      ),
      (productDetailsEntity) => emit(
        state.copyWith(
          productsDetailsLoading: false,
          failure: null,
          productDetails: productDetailsEntity,
        ),
      ),
    );
  }
}