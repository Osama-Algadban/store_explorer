import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products/data/repositories/products_repository_impl.dart';
import 'package:store_explorer/features/products/domain/entity/products_pagination_entity.dart';
import 'package:store_explorer/features/products/domain/params/products_params.dart';
import 'package:store_explorer/features/products/domain/repositories/products_repository.dart';

@lazySingleton
class ProductsUseCases {
  ProductsRepository get repository => ProductsRepositoryImpl();

  Future<Either<Failure, ProductsPaginationEntity>> getProducts(ProductsParams params) => repository.getProducts(params);
}