import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Produk {
  final int id;
  final String judul;
  final num harga;
  final String deskripsi;
  final String kategori;
  final String gambar;
  final num rating;
  final int jumlah;

  Produk(
      {required this.id,
      required this.judul,
      required this.harga,
      required this.deskripsi,
      required this.kategori,
      required this.gambar,
      required this.rating,
      required this.jumlah});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      judul: json['title'],
      harga: json['price'],
      deskripsi: json['description'],
      kategori: json['category'],
      gambar: json['image'],
      rating: json['rating']['rate'],
      jumlah: json['rating']['count'],
    );
  }

  Map<String, Object> toJson() => {
        'id': id,
        'title': judul,
        'price': harga,
        'description': deskripsi,
        'category': kategori,
        'image': gambar,
        'rating': {
          'rate': rating,
          'count': jumlah,
        },
      };
}

class ProviderProduk extends ChangeNotifier {
  List<Produk> _listProduk = [];
  List _listKategori = [];

  // 1. tempat produk serupa
  List<Produk> _listProdukSerupa = [];

  // 2. berikan akses ke produk serupa
  List<Produk> get listProdukSerupa => _listProdukSerupa;

  List<Produk> get listProduk => _listProduk;
  List get listKategori => _listKategori;

  int get jumlahProduk => _listProduk.length;
  bool isLoading = false;

  ProviderProduk() {
    _ambilProduk();
    _ambilKategori();
  }

  void _ambilProduk() async {
    isLoading = true;
    notifyListeners();

    final respon =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (respon.statusCode == 200) {
      final List data = jsonDecode(respon.body);
      _listProduk = data
          .map(
            (e) => Produk.fromJson(e),
          )
          .toList();

      isLoading = false;
      notifyListeners();
    }

    throw Exception('Gagal Mengambil data dari internet');
  }

  void _ambilKategori() async {
    isLoading = true;
    notifyListeners();

    final respon = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (respon.statusCode == 200) {
      final List data = jsonDecode(respon.body);
      _listKategori = data;
      isLoading = false;
      notifyListeners();
    }
  }

  //fungsi ambil produk serupa
  void produkKategori(String kategori) async {
    // ambil data dari internet
    final respon = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$kategori'));
    // konvert kedalam bentuk list object dart
    final List produk = jsonDecode(respon.body);
    // mapping ke dalam bentuk list produk
    List<Produk> listProduk = produk
        .map(
          (e) => Produk.fromJson(e),
        )
        .toList();
    // masukan kedalam wadah yg disiapkan di atas
    _listProdukSerupa = listProduk;
    notifyListeners();
  }
}
