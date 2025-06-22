import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static Future<List<Book>> fetchBooks(String query) async {
    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List items = jsonData['items'] ?? [];

      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data buku');
    }
  }
}
