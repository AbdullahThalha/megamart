import 'cart_items.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products; // ✅ এখন চিনবে
  final DateTime dateTime;
  final String address;
  final String paymentMethod;
  String status;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.address,
    required this.paymentMethod,
    this.status = 'paid',
  });
}
