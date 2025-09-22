import 'package:flutter/material.dart';
import 'shoes_page.dart';
import 'models/shoe.dart';
import 'app_data.dart';

class FavoritesPage extends StatefulWidget {
  final List<Shoe> favorites;

  const FavoritesPage({Key? key, required this.favorites}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final AppData appData = AppData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: appData.favorites.isEmpty
          ? Center(child: Text('No favorite items found.'))
          : ListView.builder(
              itemCount: appData.favorites.length,
              itemBuilder: (context, index) {
                final shoe = appData.favorites[index];
                return ListTile(
                  leading: Hero(
                    tag: shoe.tag,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(shoe.image),
                    ),
                  ),
                  title: Text(shoe.brand),
                  subtitle: Text('${shoe.category} - ₹${shoe.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        appData.toggleFavorite(shoe.tag);
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ShoesPage(image: shoe.image, tag: shoe.tag),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
