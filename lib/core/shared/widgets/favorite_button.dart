import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_explorer/core/managers/bloc_favorite/favorite_bloc.dart';

class FavoriteToggle extends StatelessWidget {
  final String productId;

  const FavoriteToggle({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteBloc, FavoriteState, bool>(
      selector: (state) {
        return state.favoriteIds.contains(productId);
      },
      builder: (context, isFavorite) {
        return FavoriteButton(
          isFavorite: isFavorite,
          onTap: () {
            if (isFavorite) {
              context.read<FavoriteBloc>().add(
                FavoriteEvent.removeFavoriteId(productId),
              );
            } else {
              context.read<FavoriteBloc>().add(
                FavoriteEvent.addFavoriteId(productId),
              );
            }
          },
        );
      },
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey,
          size: 22,
        ),
      ),
    );
  }
}