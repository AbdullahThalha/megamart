import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CategoryProductsPage extends StatelessWidget {
  final String categoryName;

  CategoryProductsPage({required this.categoryName});

  // 🔹 প্রতিটা category তে ৫টা করে product
  final Map<String, List<Map<String, dynamic>>> productsByCategory = {
    "Lab Equipment": [
      {"id": "p1", "title": "Microscope", "price": 2500.0},
      {"id": "p2", "title": "Test Tube Set", "price": 500.0},
      {"id": "p3", "title": "Beaker Set", "price": 800.0},
      {"id": "p4", "title": "Lab Coat", "price": 1200.0},
      {"id": "p5", "title": "Pipette", "price": 300.0},
    ],
    "Safety Equipment": [
      {"id": "p6", "title": "Safety Goggles", "price": 600.0},
      {"id": "p7", "title": "Gloves", "price": 350.0},
      {"id": "p8", "title": "Face Shield", "price": 700.0},
      {"id": "p9", "title": "Lab Mask", "price": 150.0},
      {"id": "p10", "title": "Fire Extinguisher", "price": 2000.0},
    ],
    "Industrial Tools": [
      {"id": "p11", "title": "Electric Drill", "price": 4500.0},
      {"id": "p12", "title": "Wrench Set", "price": 1200.0},
      {"id": "p13", "title": "Screwdriver Kit", "price": 800.0},
      {"id": "p14", "title": "Hammer", "price": 500.0},
      {"id": "p15", "title": "Toolbox", "price": 2500.0},
    ],
    "Measuring Instruments": [
      {"id": "p16", "title": "Digital Scale", "price": 1800.0},
      {"id": "p17", "title": "Caliper", "price": 900.0},
      {"id": "p18", "title": "Thermometer", "price": 400.0},
      {"id": "p19", "title": "Ruler Set", "price": 200.0},
      {"id": "p20", "title": "Measuring Tape", "price": 150.0},
    ],
    "Chemicals": [
      {"id": "p21", "title": "Hydrochloric Acid", "price": 800.0},
      {"id": "p22", "title": "Ethanol", "price": 1200.0},
      {"id": "p23", "title": "Sodium Chloride", "price": 300.0},
      {"id": "p24", "title": "Sulfuric Acid", "price": 1500.0},
      {"id": "p25", "title": "Glucose Powder", "price": 600.0},
    ],
    "Digital & IoT": [
      {"id": "p26", "title": "Arduino Kit", "price": 3500.0},
      {"id": "p27", "title": "Raspberry Pi", "price": 5000.0},
      {"id": "p28", "title": "Sensors Pack", "price": 2000.0},
      {"id": "p29", "title": "Smart Plug", "price": 1200.0},
      {"id": "p30", "title": "WiFi Module", "price": 800.0},
    ],
    "Medical Instruments": [
      {"id": "p31", "title": "Stethoscope", "price": 1500.0},
      {"id": "p32", "title": "Blood Pressure Monitor", "price": 3000.0},
      {"id": "p33", "title": "Syringe Set", "price": 400.0},
      {"id": "p34", "title": "Thermometer (Medical)", "price": 500.0},
      {"id": "p35", "title": "Oximeter", "price": 1200.0},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final products = productsByCategory[categoryName] ?? [];

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
                    title: Text(product["title"]),
                    subtitle: Text("৳${product["price"]}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).addItem(
                          product["id"], // productId
                          product["title"], // title
                          product["price"], // price
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
                  ),
                );
              },
            ),
    );
  }
}
