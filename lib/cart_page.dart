import 'package:flutter/material.dart';
import 'shoes_page.dart';
import 'models/shoe.dart';
import 'app_data.dart';

class CartPage extends StatefulWidget {
  final List<Shoe> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final AppData appData = AppData();

  @override
  Widget build(BuildContext context) {
    double total = appData.cart.fold(0.0, (sum, shoe) => sum + shoe.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: appData.cart.isEmpty
          ? Center(child: Text("Your cart is empty."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: appData.cart.length,
                    itemBuilder: (context, index) {
                      final shoe = appData.cart[index];
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
                          icon: Icon(Icons.remove_shopping_cart, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              appData.removeFromCart(shoe.tag);
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
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Items: ${appData.cart.length}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Total: ₹${total.toStringAsFixed(0)}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: appData.cart.isEmpty ? null : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Order Confirmed!"),
                                content: Text("Thank you for your purchase of ${appData.cart.length} items totaling ₹${total.toStringAsFixed(0)}."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        appData.cart.clear();
                                      });
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text("Checkout", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
