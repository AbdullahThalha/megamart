import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final order = context.watch<OrdersProvider>().findById(orderId);

    if (order == null) {
      return const Scaffold(body: Center(child: Text("Order not found")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Order ID: ${order.id}"),
            Text("Date: ${order.dateTime}"),
            Text("Payment: ${order.paymentMethod}"),
            Text("Status: ${order.status}"),
            Text("Address: ${order.address}"),
            const Divider(),

            const Text(
              "Products:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...order.products.map(
              (p) => ListTile(
                title: Text(p.title),
                subtitle: Text("${p.quantity} x ৳${p.price}"),
                trailing: Text("৳${(p.price * p.quantity).toStringAsFixed(2)}"),
              ),
            ),
            const Divider(),

            // Tracking (dummy)
            const Text(
              "Tracking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _trackingStep("Order Placed", true),
            _trackingStep(
              "Shipped",
              order.status == "shipped" || order.status == "delivered",
            ),
            _trackingStep("Delivered", order.status == "delivered"),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Reorder
                      final cart = context.read<CartProvider>();
                      for (final p in order.products) {
                        cart.addItem(p.id, p.title, p.price);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Items added to cart")),
                      );
                    },
                    child: const Text("Reorder"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: (order.status == "paid")
                        ? () {
                            context.read<OrdersProvider>().updateOrderStatus(
                              order.id,
                              "cancelled",
                            );
                          }
                        : null,
                    child: const Text("Cancel Order"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackingStep(String title, bool completed) {
    return Row(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completed ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}
