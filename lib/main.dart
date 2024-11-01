import 'package:flutter/material.dart';
import 'package:myapp/galeri.dart';
import 'package:myapp/provider_alamat.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:myapp/provider_produk.dart';
import 'package:myapp/store.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderProduk(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderKeranjang(),
        ),
        ChangeNotifierProvider(create: (context) => AlamatProvider(),)
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int halSaatIni = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Whatsapp',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
        body: [
          const HomePage(),
          const GaleriPage(),
          const StorePage(),
        ][halSaatIni],
        bottomNavigationBar: NavigationBar(
          selectedIndex: halSaatIni,
          onDestinationSelected: (int index) {
            setState(() {
              halSaatIni = index;
            });
          },
          indicatorColor: Colors.green.shade200,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.picture_in_picture), label: 'Galeri'),
            NavigationDestination(icon: Icon(Icons.store), label: 'Store'),
          ],
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          foregroundImage:
              NetworkImage('https://picsum.photos/id/${index * 5 + 2}/200'),
        ),
        title: const Text('Endang'),
        subtitle: Text('Pinjam dulu ${index + 1}00 besok ganti'),
        trailing: const Text('12.00'),
      ),
    );
  }
}

class TampilanListView extends StatelessWidget {
  const TampilanListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage('https://picsum.photos/id/237/200'),
          ),
          title: Text('Endang'),
          subtitle: Text('Pinjam dulu 100 besok ganti'),
        ),
        ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage('https://picsum.photos/id/237/200'),
          ),
          title: Text('Endang'),
          subtitle: Text('Pinjam dulu 100 besok ganti'),
        ),
      ],
    );
  }
}
