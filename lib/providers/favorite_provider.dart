import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/book.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Book> _favorites = [];

  List<Book> get favorites => _favorites;

  FavoriteProvider() {
    loadFavorites();
  }

  void toggleFavorite(Book book) {
    if (isFavorite(book)) {
      _favorites.removeWhere((b) => b.id == book.id);
    } else {
      _favorites.add(book);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Book book) {
    return _favorites.any((b) => b.id == book.id);
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson =
        _favorites.map((book) => jsonEncode(book.toJson())).toList();
    await prefs.setStringList('favorites', favoriteJson);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = prefs.getStringList('favorites') ?? [];

    _favorites = favoriteJson
        .map((jsonStr) => Book.fromJson(jsonDecode(jsonStr)))
        .toList();
    notifyListeners();
  }
}
