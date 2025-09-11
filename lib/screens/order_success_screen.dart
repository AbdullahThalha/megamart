import 'package:flutter/material.dart';

import 'orders_page.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  final double total;

  const OrderSuccessScreen({
    super.key,
    required this.orderId,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Success")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 96),
              const SizedBox(height: 16),
              const Text(
                "Payment Successful!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Order ID: $orderId"),
              Text("Total: ৳${total.toStringAsFixed(2)}"),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OrdersPage()),
                  );
                },
                child: const Text("View Orders"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
