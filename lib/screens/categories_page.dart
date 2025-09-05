import 'package:flutter/material.dart';

import '../data/categories.dart';
import 'category_products_page.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final category = categories[i];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(category["icon"], color: Colors.orange),
              title: Text(category["title"]),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryProductsPage(categoryName: category["title"]),
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
