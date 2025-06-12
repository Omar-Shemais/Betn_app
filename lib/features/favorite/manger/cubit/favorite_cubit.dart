import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  List<Product> _favorites = [];
  List<Product> _filteredFavorites = [];

  List<Product> get favorites =>
      _filteredFavorites.isEmpty ? _favorites : _filteredFavorites;

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    final rawItems = await CachingUtils.getFavoriteItems();
    _favorites = rawItems.map((e) => Product.fromJson(e)).toList();
    _filteredFavorites = List.from(_favorites);
    emit(FavoriteLoaded(_favorites));
  }

  Future<void> toggleFavorite(Product product) async {
    final exists = _favorites.any((element) => element.id == product.id);

    if (exists) {
      _favorites.removeWhere((element) => element.id == product.id);
    } else {
      _favorites.add(product);
    }

    await CachingUtils.saveFavoriteItems(
      _favorites.map((e) => e.toJson()).toList(),
    );
    emit(FavoriteLoaded(_favorites));
  }

  bool isFavorite(Product product) {
    return _favorites.any((element) => element.id == product.id);
  }

  Future<void> clearFavorite() async {
    await CachingUtils.clearFavorites();
    emit(FavoriteLoaded([]));
  }

  void searchFavorites(String query) {
    if (query.isEmpty) {
      _filteredFavorites = List.from(_favorites);
    } else {
      _filteredFavorites =
          _favorites
              .where(
                (product) =>
                    product.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    emit(FavoriteLoaded(_filteredFavorites));
  }

  Product? findFavoriteById(int id) {
    try {
      return _favorites.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
