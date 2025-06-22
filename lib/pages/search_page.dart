import 'package:flutter/material.dart';
import '../models/book.dart';
import '../api/api_service.dart';
import '../pages/read_page.dart';
import '../widgets/book_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Book> _books = [];
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  void _searchBooks(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await ApiService.fetchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      debugPrint('Error saat pencarian: $e');
      setState(() {
        _books = [];
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToReadPage(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReadPage(book: book),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9), // putih modern
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Cari Buku',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: _searchBooks,
                decoration: InputDecoration(
                  hintText: 'Cari judul, genre, atau penulis...',
                  hintStyle: const TextStyle(color: Colors.black54),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.black87),
                    onPressed: () => _searchBooks(_controller.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.black87),
              )
            else if (_books.isEmpty && _controller.text.isNotEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  'Tidak ada hasil ditemukan.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _navigateToReadPage(book),
                        child: BookCard(book: book),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
