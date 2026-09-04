import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoriteLocalDataSource {
  Future<List<String>> getFavoriteIds();

  Future<void> addFavoriteId(String id);

  Future<void> removeFavoriteId(String id);
}

@LazySingleton(as: FavoriteLocalDataSource)
class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _favoritesKey = 'FAVORITE_PRODUCTS_IDS';

  FavoriteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getFavoriteIds() async {
    return sharedPreferences.getStringList(_favoritesKey) ?? [];
  }

  @override
  Future<void> addFavoriteId(String id) async {
    final currentIds = await getFavoriteIds();

    if (!currentIds.contains(id)) {
      currentIds.add(id);
      await sharedPreferences.setStringList(_favoritesKey, currentIds);
    }
  }

  @override
  Future<void> removeFavoriteId(String id) async {
    final currentIds = await getFavoriteIds();

    currentIds.remove(id);

    await sharedPreferences.setStringList(_favoritesKey, currentIds);
  }
}