import 'dart:convert';
import 'package:recipe_app/core/constants/favourite_recipes.dart';
import 'package:recipe_app/features/recipe_search/models/recipe_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  static const _key = 'favoriteRecipes';

  static Future<List<Result>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Result.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<int>> getFavoritesId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => json['id'] as int).toList();
    }
    return [];
  }

  static Future<void> toggleFavorite(Result result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Result> favorites = await getFavorites();
    bool isRemoved = false;
    for (int i = 0; i < favorites.length; i++) {
      if (favorites[i].id! == result.id) {
        favorites.removeAt(i);
        isRemoved = true;
      }
    }
    if (!isRemoved) {
      favorites.add(result);
    }

    favouritesList = favorites.map((e) => e.id!).toList();

    String jsonString = jsonEncode(favorites);
    await prefs.setString(_key, jsonString);
  }
}
