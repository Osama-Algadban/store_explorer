import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/products_details/data/repositories/product_details_repository_impl.dart';
import 'package:store_explorer/features/products_details/domain/entity/product_details_entity.dart';
import 'package:store_explorer/features/products_details/domain/repositories/product_details_repository.dart';

@lazySingleton
class ProductDetailsUseCases {
  final ProductDetailsRepository repository;

  ProductDetailsUseCases([ProductDetailsRepository? repository])
      : repository = repository ?? ProductDetailsRepositoryImpl();

  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int id) =>
      repository.getProductDetails(id);


}

