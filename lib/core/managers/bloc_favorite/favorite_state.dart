part of 'favorite_bloc.dart';

@freezed
abstract class FavoriteState with _$FavoriteState {
  const factory FavoriteState({
    @Default([]) List<String> favoriteIds,
    
    @Default(false) bool isLoading,
    
    Failure? failure,
  }) = _FavoriteState;
}