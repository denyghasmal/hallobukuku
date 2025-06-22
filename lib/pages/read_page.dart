import 'package:flutter/material.dart';
import '../models/book.dart';

class ReadPage extends StatelessWidget {
  final Book book;

  const ReadPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final content = book.description?.isNotEmpty == true
        ? book.description!
        : 'Konten buku tidak tersedia.';

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD), // putih bersih
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          book.title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16.5,
              height: 1.7,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
