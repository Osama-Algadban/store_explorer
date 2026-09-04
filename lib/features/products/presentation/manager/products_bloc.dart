import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products/domain/entity/products_entity.dart';
import 'package:store_explorer/features/products/domain/entity/products_pagination_entity.dart';
import 'package:store_explorer/features/products/domain/params/products_params.dart';
import 'package:store_explorer/features/products/domain/use_cases/products_search_use_cases.dart';
import 'package:store_explorer/features/products/domain/use_cases/products_use_cases.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUseCases productsUseCases;
  final ProductsSearchUseCases productsSearchUseCases;

  final int defaultLimit = 20;
  int skip = 0;

  ProductsBloc(this.productsUseCases, this.productsSearchUseCases)
    : super(const ProductsState()) {
    on<_GetProducts>(_getProducts);
  }

  FutureOr<void> _getProducts(
    _GetProducts event,
    Emitter<ProductsState> emit,
  ) async {
    final bool reset = event.searchQuery != state.currentQuery || event.isReset;
    final bool isPaginationLoading = reset ? false : state.products.isNotEmpty ? true : false;
    final bool isLoading = reset ? true : state.products.isNotEmpty ? false : true;
    if (reset) {
      skip = 0;
    }

    emit(
      state.copyWith(
        currentQuery: event.searchQuery,
        isPaginationLoading: isPaginationLoading,
        productsLoading:isLoading,
        products: reset ? []: state.products,
        failure: null,
      ),
    );

    final ProductsParams effectiveParams = ProductsParams(
      limit: event.limit ?? defaultLimit,
      q: event.searchQuery,
      skip: skip,
    );

    final Either<Failure, ProductsPaginationEntity> result;


    if (effectiveParams.q == null) {
      result = await productsUseCases.getProducts(effectiveParams);
    } else {
      result = await productsSearchUseCases.getProductsWithSearch(
        effectiveParams,
      );
    }
    result.fold(
      (failure) => emit(
        state.copyWith(
          productsLoading: false,
          isPaginationLoading: false,
          failure: failure,
        ),
      ),
      (paginationEntity) {
        skip += defaultLimit;

        final List<ProductsEntity> updatedList = reset
            ? paginationEntity.products
            : [...state.products, ...paginationEntity.products];

        final bool hasMore =
            paginationEntity.products.isNotEmpty &&
            paginationEntity.skip  < paginationEntity.total;

        emit(
          state.copyWith(
            productsLoading: false,
            isPaginationLoading: false,
            failure: null,
            products: updatedList,
            total: paginationEntity.total,
            hasMore: hasMore
          ),
        );
      },
    );
  }
}
