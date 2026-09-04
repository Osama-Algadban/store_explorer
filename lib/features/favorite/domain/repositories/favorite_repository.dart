import 'package:dartz/dartz.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<String>>> getFavoriteIds();

  Future<Either<Failure, Unit>> addFavoriteId(String id);

  Future<Either<Failure, Unit>> removeFavoriteId(String id);
}