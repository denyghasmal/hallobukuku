# HalloBukuKu 📚

**HalloBukuKu** adalah aplikasi Flutter bertema buku digital yang dirancang dengan UI/UX rapi, bersih, dan user-friendly. Aplikasi ini memiliki 3 halaman utama:

- **Beranda** (Home)
- **Pencarian** (Search)
- **Favorit** (Favorite)

Aplikasi mendukung fitur:
- Navigasi antar halaman utama dengan `BottomNavigationBar`
- Navigasi ke halaman baca buku `read_page.dart`
- Menyukai buku dari halaman Beranda dan Pencarian
- Menampilkan buku favorit di halaman Favorit

---

## 🚀 Navigasi Aplikasi

### 1. Navigasi Utama (`BottomNavigationBar`)

Tiga halaman utama diakses melalui `BottomNavigationBar`:

- `Beranda`: Menampilkan rekomendasi buku
- `Pencarian`: Mencari dan memilih buku
- `Favorit`: Menampilkan buku yang telah disukai

#### Implementasi (`main.dart`)

```dart
int _selectedIndex = 0;

final List<Widget> _pages = [
  HomePage(),
  SearchPage(),
  FavoritePage(),
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _pages[_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pencarian'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
      ],
    ),
  );
}
```

---

### 2. Navigasi ke Halaman Baca Buku (`ReadPage`)

Dari halaman **Beranda**, **Pencarian**, atau **Favorit**, pengguna dapat mengetuk buku dan diarahkan ke halaman `read_page.dart` untuk membaca isi buku.

#### Contoh:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ReadPage(book: selectedBook),
  ),
);
```

---

### 3. Fitur Favorit Buku

- Di halaman **Beranda** dan **Pencarian**, pengguna bisa menyukai buku.
- Buku yang disukai akan otomatis ditampilkan di halaman **Favorit**.
- Data disimpan secara permanen menggunakan `shared_preferences`.

---

## 🧭 Alur Navigasi Visual

```text
BottomNavigationBar
├── HomePage
│   ├── Suka Buku → FavoritePage
│   └── Klik Buku → ReadPage
├── SearchPage
│   ├── Suka Buku → FavoritePage
│   └── Klik Buku → ReadPage
└── FavoritePage
    └── Klik Buku → ReadPage
```

---

## 📂 Struktur File Navigasi

| File | Deskripsi |
|------|-----------|
| `main.dart` | Navigasi utama aplikasi |
| `home_page.dart` | Daftar buku & tombol suka + navigasi ke `read_page.dart` |
| `search_page.dart` | Pencarian buku + tombol suka + navigasi ke `read_page.dart` |
| `favorite_page.dart` | Buku yang disukai + navigasi ke `read_page.dart` |
| `read_page.dart` | Halaman membaca isi buku |

---

## 📷 Poster

![Poster Digital](assets/poster.jpg)

---

## 📦 Build

File APK tersedia di dalam direktori proyek:

```text
/build/app/outputs/flutter-apk/app-release.apk
```

---

## 👤 Developer

**Nama**: Ach Deny Ghasmal Fuadi  
**NIM**: 2023020100029

---