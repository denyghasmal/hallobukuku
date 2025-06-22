import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../pages/read_page.dart';
import '../providers/favorite_provider.dart';
import '../widgets/book_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  void _navigateToReadPage(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ReadPage(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteBooks = context.watch<FavoriteProvider>().favorites;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // putih modern
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Buku Disukai',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: favoriteBooks.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Belum ada buku yang disukai.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: favoriteBooks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];
                return GestureDetector(
                  onTap: () => _navigateToReadPage(context, book),
                  child: BookItem(book: book),
                );
              },
            ),
    );
  }
}
