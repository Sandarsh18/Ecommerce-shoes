import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'shoes_page.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class Shoe {
  final String image;
  final String tag;
  final String brand;
  final String category;
  bool isFavorite;

  Shoe({
    required this.image,
    required this.tag,
    required this.brand,
    required this.category,
    this.isFavorite = false,
  });
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchQuery = '';
  List<String> cart = [];
  List<String> categories = ['All', 'Sneakers', 'Football', 'Soccer', 'Golf'];

  List<Shoe> shoes = [
    Shoe(image: 'assets/images/one.jpg', tag: 'red', brand: 'Nike', category: 'Sneakers'),
    Shoe(image: 'assets/images/four.jpg', tag: 'gray', brand: 'Adidas', category: 'Sneakers'),
    Shoe(image: 'assets/images/two.jpg', tag: 'blue', brand: 'Puma', category: 'Football'),
    Shoe(image: 'assets/images/five.jpg', tag: 'cyan', brand: 'Nike', category: 'Football'),
    Shoe(image: 'assets/images/three.jpg', tag: 'white', brand: 'Adidas', category: 'Soccer'),
    Shoe(image: 'assets/images/six.jpg', tag: 'black', brand: 'Puma', category: 'Soccer'),
    Shoe(image: 'assets/images/seven.jpg', tag: 'green', brand: 'Reebok', category: 'Golf'),
    Shoe(image: 'assets/images/eight.jpg', tag: 'yellow', brand: 'Callaway', category: 'Golf'),
  ];

  void toggleFavorite(String tag) {
    setState(() {
      final shoe = shoes.firstWhere((s) => s.tag == tag);
      shoe.isFavorite = !shoe.isFavorite;
    });
  }

  void addToCart(String tag) {
    setState(() {
      cart.add(tag);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added to cart!")),
    );
  }

  List<Shoe> get filteredShoes {
    return shoes.where((shoe) {
      final matchesCategory = selectedCategory == 'All' || shoe.category == selectedCategory;
      final matchesSearch = shoe.brand.toLowerCase().contains(searchQuery) ||
                            shoe.tag.toLowerCase().contains(searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: null,
        title: Text("Shoes", style: TextStyle(color: Colors.black, fontSize: 25)),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Notifications"),
                  content: Text("No new notifications."),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
                ),
              );
            },
            icon: Icon(Icons.notifications_none, color: Colors.black),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Cart"),
                      content: Text(cart.isEmpty ? "Cart is empty." : "Items in cart: \${cart.length}"),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Close"))],
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart, color: Colors.black),
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text('${cart.length}', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              // Category Selector
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    String cat = categories[index];
                    return buildCategory(cat, 1000 + (index * 100));
                  },
                ),
              ),
              SizedBox(height: 20),

              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search shoes...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Product Grid
              GridView.builder(
                itemCount: filteredShoes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final shoe = filteredShoes[index];
                  return FadeInUp(
                    duration: Duration(milliseconds: 1500 + index * 100),
                    child: buildProductCard(shoe),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(String label, int delay) {
    final isSelected = selectedCategory == label;

    IconData getCategoryIcon(String label) {
      switch (label) {
        case 'Sneakers': return Icons.directions_run;
        case 'Football': return Icons.sports_football;
        case 'Soccer': return Icons.sports_soccer;
        case 'Golf': return Icons.sports_golf;
        default: return Icons.apps;
      }
    }

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: isSelected ? 1.1 : 1.0),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(getCategoryIcon(label), size: 18, color: isSelected ? Colors.white : Colors.black),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(Shoe shoe) {
    return Hero(
      tag: shoe.tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShoesPage(image: shoe.image, tag: shoe.tag),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage(shoe.image), fit: BoxFit.cover),
            boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10, offset: Offset(0, 10))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Sneakers", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(shoe.brand, style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => toggleFavorite(shoe.tag),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: Icon(
                          shoe.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: shoe.isFavorite ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => addToCart(shoe.tag),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Add to Cart - 100\$", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
