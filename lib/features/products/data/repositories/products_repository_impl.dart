import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/exception/exception.dart';
import 'package:store_explorer/core/shared/exception/exception_extension.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:store_explorer/features/products/domain/entity/products_pagination_entity.dart';
import 'package:store_explorer/features/products/domain/params/products_params.dart';
import 'package:store_explorer/features/products/domain/repositories/products_repository.dart';

@LazySingleton(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl([ProductsRemoteDataSource? remoteDataSource])
      : remoteDataSource = remoteDataSource ?? ProductsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, ProductsPaginationEntity>> getProducts(
    ProductsParams params,
  ) async {
    try {
      final result = await remoteDataSource.getProducts(params);
      return Right(result);
    } catch (e) {
      if (e is Exception) {
        return Left(e.toFailure());
      } else {
        return Left(AppException.unknown().toFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ProductsPaginationEntity>> getProductsWithSearch(
    ProductsParams params,
  ) async {
    try {
      final result = await remoteDataSource.getProductsWithSearch(params);
      return Right(result);
    } catch (e) {
      if (e is Exception) {
        return Left(e.toFailure());
      } else {
        return Left(AppException.unknown().toFailure());
      }
    }
  }
}
