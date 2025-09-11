import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>().items.values.toList();
    final wishlistProvider = context.read<WishlistProvider>();
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: wishlist.isEmpty
          ? const Center(child: Text("No items in Wishlist"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (ctx, i) {
                final item = wishlist[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: item.imageUrl.isNotEmpty
                        ? Image.network(
                            item.imageUrl,
                            width: 60,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(width: 60),
                    title: Text(item.title),
                    subtitle: Text("৳${item.price.toStringAsFixed(2)}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Move to Cart
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            cartProvider.addItem(
                              item.id,
                              item.title,
                              item.price,
                            );
                            wishlistProvider.removeItem(item.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Moved to cart")),
                            );
                          },
                        ),
                        // Remove from wishlist
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            wishlistProvider.removeItem(item.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Removed from wishlist"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Optional: navigate to product detail (if you have ProductDetailsScreen route)
                      // Navigator.push(...);
                    },
                  ),
                );
              },
            ),
    );
  }
}
