class Book {
  final String id;
  final String title;
  final String? subtitle;
  final String? thumbnail;
  final String? description;

  Book({
    required this.id,
    required this.title,
    this.subtitle,
    this.thumbnail,
    this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // Deteksi apakah json datang dari API atau dari penyimpanan lokal
    final isFromApi = json.containsKey('volumeInfo');
    final volumeInfo = isFromApi ? json['volumeInfo'] : json;
    final imageLinks = volumeInfo['imageLinks'] ?? {};

    return Book(
      id: json['id'],
      title: volumeInfo['title'] ?? 'Tanpa Judul',
      subtitle: volumeInfo['subtitle'],
      thumbnail: imageLinks['thumbnail'] ?? volumeInfo['thumbnail'],
      description: volumeInfo['description'] ?? 'Tidak ada deskripsi tersedia.',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'thumbnail': thumbnail,
      'description': description,
    };
  }
}
