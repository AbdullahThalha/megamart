import 'package:flutter/material.dart';

import '../models/cart_items.dart';
import '../models/order.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => List.unmodifiable(_orders);

  void addOrder(
    List<CartItem> cartProducts,
    double total, {
    required String address,
    required String paymentMethod,
    String status = 'paid',
  }) {
    final newOrder = OrderItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(),
      address: address,
      paymentMethod: paymentMethod,
      status: status,
    );
    _orders.insert(0, newOrder);
    notifyListeners();
  }

  // ✅ নতুন method
  void updateOrderStatus(String orderId, String newStatus) {
    final idx = _orders.indexWhere((o) => o.id == orderId);
    if (idx >= 0) {
      _orders[idx].status = newStatus;
      notifyListeners();
    }
  }

  OrderItem? findById(String id) {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }
}
