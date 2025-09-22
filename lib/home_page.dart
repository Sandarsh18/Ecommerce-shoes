import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'shoes_page.dart';
import 'models/shoe.dart';
import 'app_data.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchQuery = '';
  List<String> categories = ['All', 'Sneakers', 'Football', 'Soccer', 'Golf'];
  final AppData appData = AppData();

  void toggleFavorite(String tag) {
    setState(() {
      appData.toggleFavorite(tag);
    });
  }

  void addToCart(String tag) {
    setState(() {
      appData.addToCart(tag);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart!")));
  }

  List<Shoe> get filteredShoes {
    return appData.shoes.where((shoe) {
      final matchCategory = selectedCategory == 'All' || shoe.category == selectedCategory;
      final matchSearch = shoe.brand.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          shoe.tag.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoe Store", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (appData.cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text('${appData.cartCount}', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Categories
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (_, i) => buildCategory(categories[i], i),
                ),
              ),
              SizedBox(height: 20),
              // Search bar
              TextField(
                onChanged: (val) => setState(() => searchQuery = val),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search shoes...",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Shoes Grid
              GridView.builder(
                itemCount: filteredShoes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 15, mainAxisSpacing: 15),
                itemBuilder: (_, index) => FadeInUp(
                  duration: Duration(milliseconds: 1200 + index * 100),
                  child: buildShoeCard(filteredShoes[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(String label, int index) {
    final isSelected = selectedCategory == label;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: isSelected ? 1.1 : 1.0),
      duration: Duration(milliseconds: 300),
      builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = label),
        child: Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Icon(
                label == 'Sneakers'
                    ? Icons.directions_run
                    : label == 'Football'
                        ? Icons.sports_football
                        : label == 'Soccer'
                            ? Icons.sports_soccer
                            : label == 'Golf'
                                ? Icons.sports_golf
                                : Icons.apps,
                size: 18,
                color: isSelected ? Colors.white : Colors.black,
              ),
              SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShoeCard(Shoe shoe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ShoesPage(image: shoe.image, tag: shoe.tag)),
        );
      },
      child: Hero(
        tag: shoe.tag,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage(shoe.image), fit: BoxFit.cover),
            boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10)],
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(shoe.brand, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(shoe.category, style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => toggleFavorite(shoe.tag),
                    child: Icon(
                      shoe.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: shoe.isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => addToCart(shoe.tag),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Text('₹${shoe.price}', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
