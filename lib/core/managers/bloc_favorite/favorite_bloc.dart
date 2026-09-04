import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:store_explorer/features/favorite/domain/use_cases/favorite_use_case.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';
part 'favorite_bloc.freezed.dart';

@lazySingleton
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteUseCases favoriteUseCases;

  FavoriteBloc(this.favoriteUseCases) : super(const FavoriteState()) {
    on<_LoadFavorites>(_loadFavorites);
    on<_AddFavoriteId>(_addFavoriteId);
    on<_RemoveFavoriteId>(_removeFavoriteId);
  }

  FutureOr<void> _loadFavorites(
    _LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await favoriteUseCases.getFavoriteIds();

    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, failure: failure),
      ),
      (ids) => emit(
        state.copyWith(isLoading: false, favoriteIds: ids),
      ),
    );
  }

  FutureOr<void> _addFavoriteId(
    _AddFavoriteId event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await favoriteUseCases.addFavoriteId(event.productId);

    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) {
        if (!state.favoriteIds.contains(event.productId)) {
          emit(
            state.copyWith(
              favoriteIds: [...state.favoriteIds, event.productId],
              failure: null,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _removeFavoriteId(
    _RemoveFavoriteId event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await favoriteUseCases.removeFavoriteId(event.productId);

    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) {
        final updatedIds = state.favoriteIds
            .where((id) => id != event.productId)
            .toList();

        emit(
          state.copyWith(
            favoriteIds: updatedIds,
            failure: null,
          ),
        );
      },
    );
  }
}