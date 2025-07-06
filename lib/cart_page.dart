import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> cart;

  @override
  void initState() {
    super.initState();
    cart = List.from(widget.cartItems);
  }

  double get totalPrice {
    return cart.fold(0, (sum, item) => sum + (item['price'] ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: cart.isEmpty
          ? const Center(child: Text("🛒 Your cart is empty"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.asset(item['image'], width: 50),
                  title: Text(item['name']),
                  subtitle: Text("₹${item['price']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        cart.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ₹${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("🧾 Order placed!")),
                      );
                    },
                    child: const Text("Checkout"),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
