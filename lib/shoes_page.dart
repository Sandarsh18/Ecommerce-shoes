import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ShoesPage extends StatefulWidget {
  final String image;
  final String tag;

  const ShoesPage({Key? key, required this.image, required this.tag}) : super(key: key);

  @override
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  String selectedSize = '42';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.tag,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(widget.image), fit: BoxFit.cover),
                boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10, offset: Offset(0, 10))],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Center(child: Icon(Icons.favorite_border, size: 20)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: 380,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [Colors.black.withValues(alpha: 0.9), Colors.black.withValues(alpha: 0.0)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text("Sneakers", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Text("Size", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        buildSizeButton("40", 1450),
                        buildSizeButton("42", 1500),
                        buildSizeButton("44", 1550),
                        buildSizeButton("46", 1600),
                      ],
                    ),
                    SizedBox(height: 40),
                    FadeInUp(
                      duration: Duration(milliseconds: 1650),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Order Placed!"),
                              content: Text("Thank you for your purchase of size $selectedSize."),
                              actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text("Buy Now", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSizeButton(String size, int delay) {
    final isSelected = selectedSize == size;
    return FadeInUp(
      duration: Duration(milliseconds: delay),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSize = size;
          });
        },
        child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? null : Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
          ),
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
