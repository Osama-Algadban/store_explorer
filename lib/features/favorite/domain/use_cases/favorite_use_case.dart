import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/favorite/domain/repositories/favorite_repository.dart';

@lazySingleton
class FavoriteUseCases {
  final FavoriteRepository repository;

  FavoriteUseCases(this.repository);

  Future<Either<Failure, List<String>>> getFavoriteIds() {
    return repository.getFavoriteIds();
  }

  Future<Either<Failure, Unit>> addFavoriteId(String id) {
    return repository.addFavoriteId(id);
  }

  Future<Either<Failure, Unit>> removeFavoriteId(String id) {
    return repository.removeFavoriteId(id);
  }
}