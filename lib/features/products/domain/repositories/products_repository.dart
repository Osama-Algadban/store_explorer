import 'package:dartz/dartz.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products/domain/entity/products_pagination_entity.dart';
import 'package:store_explorer/features/products/domain/params/products_params.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductsPaginationEntity>> getProducts(ProductsParams params);
  Future<Either<Failure, ProductsPaginationEntity>> getProductsWithSearch(ProductsParams params) ;
}
