import 'package:flutter/material.dart';
import 'package:myapp/detail.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/provider_produk.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderProduk>(
        builder: (context, value, child) {
          if (value.isLoading) {
            const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.listKategori.length,
                      itemBuilder: (context, index) {
                        final String kategori = value.listKategori[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.pink,
                          ),
                          child: Text(
                            kategori,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: value.jumlahProduk,
                    itemBuilder: (context, index) {
                      final produk = value.listProduk[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(produk: produk,),
                            )),
                        child: GridTile(
                            header: Container(
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.pink,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Image.network(produk.gambar)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.pink,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    produk.kategori.toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Text(
                                  produk.judul,
                                  style: const TextStyle(fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(rp(produk.harga)),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        ),
                                        Text('(${produk.rating})')
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
