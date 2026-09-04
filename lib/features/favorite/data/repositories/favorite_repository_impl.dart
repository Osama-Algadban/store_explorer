import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/favorite/data/data_sources/favorite_local_data_source.dart';
import 'package:store_explorer/features/favorite/domain/repositories/favorite_repository.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<String>>> getFavoriteIds() async {
    try {
      final ids = await localDataSource.getFavoriteIds();
      return Right(ids);
    } catch (e) {
      return Left(Failure(message: e.toString(), title: ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> addFavoriteId(String id) async {
    try {
      await localDataSource.addFavoriteId(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString(), title: ''));

    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavoriteId(String id) async {
    try {
      await localDataSource.removeFavoriteId(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString(), title: ''));

    }
  }
}