import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Alamat {
  final int? id;
  final String namaPenerima;
  final String alamatPengiriman;
  Alamat({
    this.id,
    required this.namaPenerima,
    required this.alamatPengiriman,
  });

  factory Alamat.fromMap(Map<String, dynamic> map) {
    return Alamat(
      id: map['id'],
      namaPenerima: map['namaPenerima'],
      alamatPengiriman: map['alamatPengiriman'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'namaPenerima': namaPenerima,
      'alamatPengiriman': alamatPengiriman,
    };
  }

  @override
  String toString() =>
      'Alamat{id: $id, namaPenerima: $namaPenerima, alamatPengiriman: $alamatPengiriman}';
}

class AlamatProvider extends ChangeNotifier {
  List<Alamat> _listAlamat = [];
  List<Alamat> get listAlamat => _listAlamat;

  // buat konstruktor yg akan otomatis dijalankan
  AlamatProvider() {
    _ambilAlamat();
  }

// membuka koneksi databse
  Future<Database> _dbHelper() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'db_alamat.db'),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE tb_alamat(id INTEGER PRIMARY KEY, namaPenerima TEXT, alamatPengiriman TEXT)'),
      version: 1,
    );
    return database;
  }

// fungsi tambah alamat ke tabel alamat
  Future<void> tambahAlamat(Alamat alamat) async {
    final db = await _dbHelper();
    await db.insert('tb_alamat', alamat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await _ambilAlamat();
  }

// fungsi mengambil data dari tabel alamat
  Future<void> _ambilAlamat() async {
    final db = await _dbHelper();
    final listMapAlamat = await db.query('tb_alamat');
    final listAlamat = listMapAlamat
        .map(
          (e) => Alamat.fromMap(e),
        )
        .toList();
    _listAlamat = listAlamat;
    notifyListeners();
  }
}
