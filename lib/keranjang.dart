import 'package:flutter/material.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:myapp/provider_produk.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('ini halaman keranjang')),
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
          return ListTile(
            leading: Image.network(produk.gambar),
          );
        },
      ),
    );
  }
}
