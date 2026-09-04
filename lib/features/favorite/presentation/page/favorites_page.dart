import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_explorer/core/managers/bloc_favorite/favorite_bloc.dart';
import 'package:store_explorer/core/managers/service_locator/service_locator.dart';
import 'package:store_explorer/core/shared/widgets/main_loader.dart';
import 'package:store_explorer/features/products/presentation/manager/products_bloc.dart';
import 'package:store_explorer/features/products/presentation/widgets/product_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoriteBloc _favoriteBloc;
  late final ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getIt<FavoriteBloc>()
      ..add(const FavoriteEvent.loadFavorites());

    _productsBloc = getIt<ProductsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _favoriteBloc),
        BlocProvider.value(value: _productsBloc),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('المفضلة')),
        body: SafeArea(
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favState) {
              if (favState.isLoading) {
                return const Center(child: MainLoader());
              }

              if (favState.favoriteIds.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'لا توجد منتجات في المفضلة',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, prodState) {
                  final favoriteProducts = prodState.products.where((product) {
                    return favState.favoriteIds.contains(product.id.toString());
                  }).toList();

                  if (favoriteProducts.isEmpty) {
                    return const Center(child: Text('لا يوجد منتجات في المفضلة'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = favoriteProducts[index];

                      return BlocSelector<FavoriteBloc, FavoriteState, bool>(
                        selector: (state) {
                          return state.favoriteIds.contains(product.id.toString());
                        },
                        builder: (context, isFav) {
                          return ProductCard(
                            product: product,
                            isFavorite: isFav,
                            onFavoriteTap: () {
                              context.read<FavoriteBloc>().add(
                                FavoriteEvent.removeFavoriteId(product.id.toString()),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}