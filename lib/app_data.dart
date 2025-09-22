import 'models/shoe.dart';

class AppData {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  List<Shoe> _favorites = [];
  List<Shoe> _cart = [];

  List<Shoe> shoes = [
    Shoe(image: 'assets/images/one.jpg', tag: 'red', brand: 'Nike', category: 'Sneakers', price: 5499),
    Shoe(image: 'assets/images/four.jpg', tag: 'gray', brand: 'Adidas', category: 'Sneakers', price: 4999),
    Shoe(image: 'assets/images/two.jpg', tag: 'blue', brand: 'Puma', category: 'Football', price: 3599),
    Shoe(image: 'assets/images/five.jpg', tag: 'cyan', brand: 'Nike', category: 'Football', price: 3999),
    Shoe(image: 'assets/images/three.jpg', tag: 'white', brand: 'Adidas', category: 'Soccer', price: 4299),
    Shoe(image: 'assets/images/six.jpg', tag: 'black', brand: 'Puma', category: 'Soccer', price: 3799),
    Shoe(image: 'assets/images/seven.jpg', tag: 'green', brand: 'Reebok', category: 'Golf', price: 5699),
    Shoe(image: 'assets/images/eight.jpg', tag: 'yellow', brand: 'Callaway', category: 'Golf', price: 5999),
  ];

  List<Shoe> get favorites => _favorites;
  List<Shoe> get cart => _cart;

  void toggleFavorite(String tag) {
    final shoe = shoes.firstWhere((s) => s.tag == tag);
    shoe.isFavorite = !shoe.isFavorite;
    
    if (shoe.isFavorite) {
      if (!_favorites.any((s) => s.tag == tag)) {
        _favorites.add(shoe);
      }
    } else {
      _favorites.removeWhere((s) => s.tag == tag);
    }
  }

  void addToCart(String tag) {
    final shoe = shoes.firstWhere((s) => s.tag == tag);
    _cart.add(shoe);
  }

  void removeFromCart(String tag) {
    _cart.removeWhere((s) => s.tag == tag);
  }

  int get cartCount => _cart.length;
}
