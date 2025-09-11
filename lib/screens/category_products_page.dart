import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import 'product_details_screen.dart';

class CategoryProductsPage extends StatelessWidget {
  final String categoryName;

  CategoryProductsPage({required this.categoryName});

  // 🔹 প্রতিটা category তে products
  final Map<String, List<Map<String, dynamic>>> productsByCategory = {
    "Lab Equipment": [
      {
        "id": "p1",
        "title": "Microscope",
        "price": 2500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p2",
        "title": "Test Tube Set",
        "price": 500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p3",
        "title": "Beaker Set",
        "price": 800.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p4",
        "title": "Lab Coat",
        "price": 1200.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p5",
        "title": "Pipette",
        "price": 300.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
    "Safety Equipment": [
      {
        "id": "p6",
        "title": "Safety Goggles",
        "price": 600.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p7",
        "title": "Gloves",
        "price": 350.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p8",
        "title": "Face Shield",
        "price": 700.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p9",
        "title": "Lab Mask",
        "price": 150.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p10",
        "title": "Fire Extinguisher",
        "price": 2000.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
    "Industrial Tools": [
      {
        "id": "p11",
        "title": "Electric Drill",
        "price": 4500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p12",
        "title": "Wrench Set",
        "price": 1200.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p13",
        "title": "Screwdriver Kit",
        "price": 800.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p14",
        "title": "Hammer",
        "price": 500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p15",
        "title": "Toolbox",
        "price": 2500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
    "Measuring Instruments": [
      {
        "id": "p16",
        "title": "Digital Scale",
        "price": 1800.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p17",
        "title": "Caliper",
        "price": 900.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p18",
        "title": "Thermometer",
        "price": 400.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p19",
        "title": "Ruler Set",
        "price": 200.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p20",
        "title": "Measuring Tape",
        "price": 150.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
    "Chemicals": [
      {
        "id": "p21",
        "title": "Hydrochloric Acid",
        "price": 800.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p22",
        "title": "Ethanol",
        "price": 1200.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p23",
        "title": "Sodium Chloride",
        "price": 300.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p24",
        "title": "Sulfuric Acid",
        "price": 1500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p25",
        "title": "Glucose Powder",
        "price": 600.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
    "Digital & IoT": [
      {
        "id": "p26",
        "title": "Arduino Kit",
        "price": 3500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p27",
        "title": "Raspberry Pi",
        "price": 5000.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p28",
        "title": "Sensors Pack",
        "price": 2000.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p29",
        "title": "Smart Plug",
        "price": 1200.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p30",
        "title": "WiFi Module",
        "price": 800.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
    "Medical Instruments": [
      {
        "id": "p31",
        "title": "Stethoscope",
        "price": 1500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p32",
        "title": "Blood Pressure Monitor",
        "price": 3000.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p33",
        "title": "Syringe Set",
        "price": 400.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p34",
        "title": "Thermometer (Medical)",
        "price": 500.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
      {
        "id": "p35",
        "title": "Oximeter",
        "price": 1200.0,
        "imageUrl": "https://via.placeholder.com/150",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final products = productsByCategory[categoryName] ?? [];
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: products.isEmpty
          ? Center(child: Text("No products found for $categoryName"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                final product = products[i];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Consumer<WishlistProvider>(
                      builder: (ctx, wishlist, _) => IconButton(
                        icon: Icon(
                          wishlist.isInWishlist(product["id"])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          wishlist.toggleItem(
                            product["id"],
                            product["title"],
                            product["price"],
                            product["imageUrl"] ?? "",
                          );
                        },
                      ),
                    ),
                    title: Text(product["title"]),
                    subtitle: Text("৳${product["price"]}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        cartProvider.addItem(
                          product["id"],
                          product["title"],
                          product["price"],
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product["title"]} added to cart 🛒",
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text("Add to Cart"),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            id: product["id"],
                            title: product["title"],
                            price: product["price"],
                            imageUrl: product["imageUrl"] ?? "",
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
