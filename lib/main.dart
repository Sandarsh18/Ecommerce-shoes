import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'cart_page.dart';
import 'notifications_page.dart';

void main() {
  runApp(ShoeStoreApp());
}

class ShoeStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce Shoe Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/favorites': (context) => FavoritesPage(favorites: []),
        '/cart': (context) => CartPage(cart: []),
        '/notifications': (context) => NotificationsPage(),
      },
    );
  }
}
