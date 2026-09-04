part of 'favorite_bloc.dart';

@freezed
abstract class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.loadFavorites() = _LoadFavorites;

  const factory FavoriteEvent.addFavoriteId(String productId) = _AddFavoriteId;

  const factory FavoriteEvent.removeFavoriteId(String productId) = _RemoveFavoriteId;


}