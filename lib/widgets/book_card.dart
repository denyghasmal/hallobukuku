import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart' as model;
import '../providers/favorite_provider.dart';

class BookCard extends StatelessWidget {
  final model.Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(book);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: book.thumbnail != null
                ? Image.network(
                    book.thumbnail!,
                    width: 60,
                    height: 90,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.book, size: 60, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                if (book.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      book.subtitle!,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : Colors.grey[400],
            ),
            onPressed: () => favoriteProvider.toggleFavorite(book),
          ),
        ],
      ),
    );
  }
}
