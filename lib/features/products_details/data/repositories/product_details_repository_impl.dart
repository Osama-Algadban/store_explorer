import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/exception/exception.dart';
import 'package:store_explorer/core/shared/exception/exception_extension.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products_details/data/data_sources/product_details_remote_data_source.dart';
import 'package:store_explorer/features/products_details/domain/entity/product_details_entity.dart';
import 'package:store_explorer/features/products_details/domain/repositories/product_details_repository.dart';

@LazySingleton(as: ProductDetailsRepository)
class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImpl([ProductDetailsRemoteDataSource? remoteDataSource])
      : remoteDataSource =
            remoteDataSource ?? ProductDetailsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int id) async {
    try {
      final result = await remoteDataSource.getProductDetails(id);
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

