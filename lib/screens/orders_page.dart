import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import 'order_details_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersProvider>().orders;

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: orders.isEmpty
          ? const Center(child: Text("No orders yet"))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) {
                final o = orders[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      "৳${o.amount.toStringAsFixed(2)} • ${o.paymentMethod}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${o.products.length} items • ${o.dateTime.toLocal().toString().substring(0, 16)}",
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: o.status == "paid"
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        o.status.toUpperCase(),
                        style: TextStyle(
                          color: o.status == "paid" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // 🔽 এখানেই পরিবর্তন:
                    onExpansionChanged: (expanded) {
                      if (expanded) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderDetailsPage(orderId: o.id),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
