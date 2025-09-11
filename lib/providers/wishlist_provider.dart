import 'package:flutter/material.dart';

import '../models/wishlist_item.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistItem> _items = {};

  // read-only getter
  Map<String, WishlistItem> get items => {..._items};

  // total wishlist count
  int get itemCount => _items.length;

  // check product exists
  bool isInWishlist(String id) => _items.containsKey(id);

  // toggle behaviour: add/remove
  void toggleItem(String id, String title, double price, String imageUrl) {
    if (_items.containsKey(id)) {
      _items.remove(id);
    } else {
      _items[id] = WishlistItem(
        id: id,
        title: title,
        price: price,
        imageUrl: imageUrl,
      );
    }
    notifyListeners();
  }

  // remove single item
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  // clear all items
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
