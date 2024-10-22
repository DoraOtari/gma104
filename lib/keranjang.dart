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
    return Column(
      children: [
        Expanded(
          child: Consumer<ProviderKeranjang>(
            builder: (context, value, child) => ListView.builder(
              itemCount: value.jumlahKeranjang,
              itemBuilder: (context, index) {
                Produk produk = value.listKeranjang[index];
                return Dismissible(
                  confirmDismiss: (_) async {
                    bool confirm = await showDialog(
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
                    );
                    return confirm;
                  },
                  onDismissed: (_) =>
                      Provider.of<ProviderKeranjang>(context, listen: false)
                          .hapusProduk(produk.id),
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
                  key: GlobalKey(),
                  child: ListTile(
                    leading: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(produk.gambar)),
                    title: Text(produk.judul),
                    subtitle: Text(rp(produk.harga)),
                  ),
                );
              },
            ),
          ),
        ),
        const TotalBayar(),
        const TombolPesan()
      ],
    );
  }
}

class TotalBayar extends StatelessWidget {
  const TotalBayar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Text(
            'Total Bayar',
            style: TextStyle(fontSize: 20),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Qty'),
              Consumer<ProviderKeranjang>(
                builder: (context, value, child) =>
                    Text(value.jumlahKeranjang.toString()),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Harga'),
              Consumer<ProviderKeranjang>(
                builder: (context, value, child) => Text(rp(value.totalBayar)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TombolPesan extends StatelessWidget {
  const TombolPesan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: ElevatedButton(
          style: const ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              backgroundColor: WidgetStatePropertyAll(Colors.pink)),
          onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const BagianFormAlamat(),
              ),
          child: const Text('Pesan Sekarang')),
    );
  }
}

class BagianFormAlamat extends StatelessWidget {
  const BagianFormAlamat({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
                width: 100,
                child: Divider(
                  thickness: 5,
                )),
            const Text(
              'Informasi Pemesanan',
              style: TextStyle(fontSize: 24),
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Nama Penerima')),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Alamat Pengiriman')),
            ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(color: Colors.pink),
                child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Simpan',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
