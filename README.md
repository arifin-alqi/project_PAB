# TUGAS PAB_PER 4_PART 5

Aplikasi Shopping

## Deskripsi

Project ini bertujuan untuk menyelasaikan tugas dari mata kuliah "pemograman Aplikasi Bergerak", tugas ini menggunakan framework flutter dengan state management provider. Aplikasi hasilnya bisa menampilkan sebuah daftar produk dan fitur keranjang sederhana.


Dari program terbaru memiliki fitur tambahan berupa search, katagori, dan fitur checkout seperti pengisian data dan alamat.

# FITUR

### 1. Search/Katagori

Fitur ini digunakan untuk mencari barang yang di inginkan dan pengelompokan barang sesuai katagori,

### 2. Keranjang

Fitur ini adalah tempat pengelompokan suatu barang yang ingin di beli dari customer.

### 3. Tambah, Kurang dan Hapus

Fitur adalah fitur dasar yang digunakan dalam belanja, jadi fitur ini digunakan apa bila barang yang ingin di beli lebih dari atau kurang dari yang di inginkan dan juga bisa membatakan barang dalam keranjang.

### 4. Checkout

Fitur yang dimana digunakan untuk melihat daftar seluruh biaya, pengsian data juga proses detail barang yang di pesan hingga metode pembayaran.

# STRUKTUR FOLDER

```
lib
│
├── data
│   └── product_data.dart
│
├── models
│   ├── product.dart
│   ├── cart_item.dart
│   └── cart_model.dart
│
├── pages
│   ├── home_page.dart
│   ├── cart_page.dart
│   └── checkout_page.dart
│
├── widgets
│   └── product_card.dart
│
└── main.dart
```

# KOMPONEN

### Product

```
Menyimpan data produk:

id
nama
harga
gambar
kategori
CartItem

Menyimpan item yang dimasukkan ke keranjang:

produk
quantity
total harga
CartModel

Mengatur seluruh logic keranjang:

tambah item
hapus item
tambah quantity
kurangi quantity
clear cart
hitung total harga
Class ini menggunakan ChangeNotifier agar UI dapat diperbarui otomatis.
```

# DATA DIRI

Muhammad Arifin Alqi. AB

2409116106

Sistem Informasi
