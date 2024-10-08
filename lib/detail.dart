import 'package:flutter/material.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/keranjang.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:myapp/provider_produk.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final Produk produk;
  const DetailPage({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KeranjangPage(),
                    ));
              },
              icon: Badge(
                  label: Consumer<ProviderKeranjang>(
                    builder: (context, value, child) =>
                        Text(value.jumlahKeranjang.toString()),
                  ),
                  child: const Icon(Icons.shopping_bag_rounded)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(produk.gambar),
              ),
              Text(produk.kategori.toUpperCase()),
              Text(
                produk.judul,
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    rp(produk.harga),
                    style: const TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people),
                      Text(
                        produk.jumlah.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: const Text(
                  'Deskripsi Produk',
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                color: Colors.pink.shade100,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(produk.deskripsi)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: const Text(
                  'Produk Serupa',
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<ProviderProduk>(
                builder: (context, providerProduk, child) {
                  providerProduk.produkKategori(produk.kategori);
                  // jika sudah tampilkan data
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: providerProduk.listProdukSerupa.length,
                      itemBuilder: (context, index) {
                        final produk = providerProduk.listProdukSerupa[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          width: 150,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(child: Image.network(produk.gambar)),
                                  Text(
                                    produk.judul,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    rp(produk.harga),
                                    style: const TextStyle(color: Colors.pink),
                                  ),
                                  Text('${produk.jumlah} Terjual')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Provider.of<ProviderKeranjang>(context, listen: false)
              .simpanProduk(produk);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Berhasil Masukan Produk ke Keranjang')));
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            backgroundColor:
                WidgetStatePropertyAll(Colors.pink.withOpacity(0.7))),
      ),
    );
  }
}
