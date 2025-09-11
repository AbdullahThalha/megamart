import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  ProductDetailsScreen({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Consumer<WishlistProvider>(
            builder: (ctx, wishlist, _) => IconButton(
              icon: Icon(
                wishlist.isInWishlist(id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                wishlist.toggleItem(id, title, price, imageUrl);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wishlist.isInWishlist(id)
                          ? "Added to Wishlist ❤️"
                          : "Removed from Wishlist ❌",
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "৳${price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("This is a detailed description of the product."),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.addItem(id, title, price);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Cart 🛒")),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 50,
                ),
              ),
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
