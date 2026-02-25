# TUGAS PAB_PER 4_PART 5

Aplikasi Shopping

## Deskripsi

Project ini bertujuan untuk menyelasaikan tugas dari mata kuliah "pemograman Aplikasi Bergerak", tugas ini menggunakan framework flutter dengan state management provider. Aplikasi hasilnya bisa menampilkan sebuah daftar produk dan fitur keranjang sederhana.


Dari program terbaru memiliki fitur tambahan berupa search, katagori, dan fitur checkout seperti pengisian data dan alamat.

# FITUR

### 1. Search/Katagori

Fitur ini digunakan untuk mencari barang yang di inginkan dan pengelompokan barang sesuai katagori.

<img width="1918" height="915" alt="image" src="https://github.com/user-attachments/assets/b98c6f66-58c9-4c01-96b5-8a8a5a2c70c1" />


### 2. Keranjang

Fitur ini adalah tempat pengelompokan suatu barang yang ingin di beli dari customer.

<img width="1919" height="913" alt="image" src="https://github.com/user-attachments/assets/ad05a1bc-f630-49c1-a005-fe9eea7afc02" />


### 3. Tambah, Kurang dan Hapus

Fitur adalah fitur dasar yang digunakan dalam belanja, jadi fitur ini digunakan apa bila barang yang ingin di beli lebih dari atau kurang dari yang di inginkan dan juga bisa membatakan barang dalam keranjang.

<img width="1918" height="206" alt="image" src="https://github.com/user-attachments/assets/5a70055d-a8cd-44eb-aff7-ddfa6c087a48" />

### 4. Checkout

Fitur yang dimana digunakan untuk melihat daftar seluruh biaya, pengsian data juga proses detail barang yang di pesan hingga metode pembayaran.

<img width="1919" height="910" alt="image" src="https://github.com/user-attachments/assets/0bd213d7-2efc-49e3-9379-4048e6d60869" />


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
