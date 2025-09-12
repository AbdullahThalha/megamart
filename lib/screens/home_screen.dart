import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import 'cart_screen.dart';
import 'categories_page.dart';
import 'category_products_page.dart'; // ✅ category navigation এর জন্য import
import 'orders_page.dart';
import 'product_details_screen.dart';
import 'profile_page.dart';
import 'wishlist_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    CartScreen(),
    OrdersPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ------------------ Home Page ------------------

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> dummyProducts = [
    {
      "id": "p1",
      "title": "Lab Coat",
      "price": 1200.0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "id": "p2",
      "title": "Safety Goggles",
      "price": 600.0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "id": "p3",
      "title": "Gloves",
      "price": 350.0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "id": "p4",
      "title": "Beaker",
      "price": 150.0,
      "imageUrl": "https://via.placeholder.com/150",
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.biotech, "title": "Lab Equipment"},
    {"icon": Icons.health_and_safety, "title": "Safety Equipment"},
    {"icon": Icons.build, "title": "Industrial Tools"},
    {"icon": Icons.straighten, "title": "Measuring Instruments"},
    {"icon": Icons.science, "title": "Chemicals"},
    {"icon": Icons.memory, "title": "Digital & IoT"},
    {"icon": Icons.medical_services, "title": "Medical Instruments"},
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MegaMart Home"),
        actions: [
          // Wishlist icon
          Consumer<WishlistProvider>(
            builder: (ctx, wishlist, _) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WishlistPage()),
                    );
                  },
                ),
                if (wishlist.itemCount > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        wishlist.itemCount.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Cart icon
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.itemCount.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // ✅ Categories row (now functional)
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryProductsPage(
                              categoryName: categories[i]["title"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categories[i]["icon"],
                              size: 36,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 6),
                            Flexible(
                              child: Text(
                                categories[i]["title"],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Products grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                itemCount: dummyProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, i) {
                  final product = dummyProducts[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            id: product["id"],
                            title: product["title"],
                            price: product["price"],
                            imageUrl: product["imageUrl"],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.network(product["imageUrl"], height: 80),
                              Positioned(
                                right: 0,
                                child: Consumer<WishlistProvider>(
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
                                        product["imageUrl"],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("৳${product["price"]}"),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).addItem(
                                product["id"],
                                product["title"],
                                product["price"],
                              );
                            },
                            child: const Text("Add to Cart"),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
