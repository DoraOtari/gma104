import 'package:flutter/material.dart';

class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key});

  @override
  State<GaleriPage> createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  final List listFavorit = List.generate(
    10,
    (index) => false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.5),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5.5, crossAxisSpacing: 5.5, crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GridTile(
                footer: Container(
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        listFavorit[index] = !listFavorit[index];
                      });
                    },
                    icon: Icon(
                      listFavorit[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.pink,
                      size: 32,
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                      'https://picsum.photos/id/${index * 5 + 2}/200'),
                ));
          },
        ),
      ),
    );
  }
}
