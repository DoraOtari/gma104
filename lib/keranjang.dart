import 'package:flutter/material.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:myapp/provider_produk.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: const ListProduk(),
    );
  }
}

class ListProduk extends StatelessWidget {
  const ListProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderKeranjang>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.jumlahKeranjang,
        itemBuilder: (context, index) {
          Produk produk = value.listKeranjang[index];
          return Dismissible(
            onDismissed: (_) => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Konfirmasi Perintah'),
                content: const Text(
                    'Apakah anda yakin ingin menghapus produk dari keranjang'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Tidak')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Ya')),
                ],
              ),
            ),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.pink,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 28,
              ),
            ),
            key: UniqueKey(),
            child: ListTile(
              leading: AspectRatio(
                  aspectRatio: 1 / 1, child: Image.network(produk.gambar)),
              title: Text(produk.judul),
              subtitle: Text(rp(produk.harga)),
            ),
          );
        },
      ),
    );
  }
}
