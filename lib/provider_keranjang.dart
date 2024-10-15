import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/provider_produk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderKeranjang extends ChangeNotifier {
  List<Produk> _listKeranjang = [];

  List<Produk> get listKeranjang => _listKeranjang;
  int get jumlahKeranjang => _listKeranjang.length;
  num get totalBayar => _hitungBelanja();

  ProviderKeranjang() {
    _ambilProduk();
    _hitungBelanja();
  }

  num _hitungBelanja() {
    num total = 0;
    for (var produk in _listKeranjang) {
      total += produk.harga;
    }
    return total;
  }

  void _ambilProduk() async {
    final pref = await SharedPreferences.getInstance();
    // jika data belum ada
    List<String> dataKeranjang = pref.getStringList('listKeranjang') ?? [];

    // jika ada data
    _listKeranjang = dataKeranjang
        .map(
          (e) => Produk.fromJson(jsonDecode(e)),
        )
        .toList();
    notifyListeners();
  }

  void _tambahKeranjang() async {
    final pref = await SharedPreferences.getInstance();

    List<String> dataKeranjang = _listKeranjang
        .map(
          (e) => jsonEncode(e.toJson()),
        )
        .toList();
    pref.setStringList('listKeranjang', dataKeranjang);
  }

  void simpanProduk(Produk produk) {
    _listKeranjang.add(produk);
    _tambahKeranjang();
    notifyListeners();
  }

  void _hapusKeranjang() async {
    final pref = await SharedPreferences.getInstance();
    List<String> dataKeranjang = _listKeranjang
        .map(
          (e) => jsonEncode(e.toJson()),
        )
        .toList();
    pref.setStringList('listKeranjang', dataKeranjang);
  }

  void hapusProduk(int id) {
    _listKeranjang.removeWhere((element) => element.id == id);
    _hapusKeranjang();
    notifyListeners();
  }
}
