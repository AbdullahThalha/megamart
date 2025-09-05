import 'package:flutter/material.dart';

import '../models/cart_items.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  // Cart-এর সব item access করার জন্য getter
  Map<String, CartItem> get items => _items;

  // Cart-এ unique item count
  int get itemCount => _items.length;

  // Cart-এর মোট দাম
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Cart-এ নতুন item add করা
  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // যদি product already থাকে → quantity 1 বাড়ানো
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // নতুন product add করা
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners(); // UI update করার জন্য
  }

  // নির্দিষ্ট item remove করা
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Cart clear করা
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
