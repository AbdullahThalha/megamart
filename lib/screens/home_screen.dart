import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'categories_page.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Screens for bottom nav
  final List<Widget> _pages = [
    HomePage(), // Main Home content
    CategoriesPage(), // Categories
    CartScreen(), // Cart
    OrdersPage(), // Orders
    ProfilePage(), // Profile
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
        title: Text("MegaMart Home"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
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
                      style: TextStyle(fontSize: 12, color: Colors.white),
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
              // ---------------- Search Bar ----------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // --------------- Category Row ----------------
              Container(
                height: 120, // ⬅️ height বাড়ানো হলো
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categories[i]["icon"],
                              size: 36, // ⬅️ একটু বড়
                              color: Colors.orange,
                            ),
                            SizedBox(height: 6),
                            Flexible(
                              // ⬅️ Text overflow handle করার জন্য
                              child: Text(
                                categories[i]["title"],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2, // ⬅️ long text হলে ২ লাইনে আসবে
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

              SizedBox(height: 10),

              // --------------- Featured Banner / Slider ----------------
              Container(
                height: 120,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: PageView(
                  children: [
                    Container(
                      color: Colors.orange.shade200,
                      child: Center(child: Text("New Arrival")),
                    ),
                    Container(
                      color: Colors.orange.shade300,
                      child: Center(child: Text("Discount Offer")),
                    ),
                    Container(
                      color: Colors.orange.shade400,
                      child: Center(child: Text("Special Deals")),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // --------------- Product Grid ----------------
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemCount: dummyProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          Image.network(product["imageUrl"], height: 80),
                          SizedBox(height: 5),
                          Text(
                            product["title"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("\$${product["price"]}"),
                          Expanded(child: SizedBox()), // ✅ Spacer → Expanded
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
                            child: Text("Add to Cart"),
                          ),
                          SizedBox(height: 5),
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

// ---------------- Placeholder screens for BottomNav ----------------

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text("Orders Page")));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text("Profile Page")));
}
