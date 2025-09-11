import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';
import 'order_success_screen.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();

  String _paymentMethod = 'COD'; // 'COD' | 'Card'

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final cart = context.read<CartProvider>();
    final orders = context.read<OrdersProvider>();

    final mergedAddress =
        "${_nameCtrl.text}, ${_phoneCtrl.text}\n${_addressCtrl.text}, ${_cityCtrl.text}";

    // Card (Demo) হলে আগে payment screen
    if (_paymentMethod == 'Card') {
      final paid = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentScreen(amount: cart.totalAmount),
        ),
      );

      if (paid != true) return; // user canceled or failed
    }

    // Order save
    orders.addOrder(
      cart.items.values.toList(),
      cart.totalAmount,
      address: mergedAddress,
      paymentMethod: _paymentMethod,
      status: 'paid',
    );

    final total = cart.totalAmount;
    final lastOrderId = orders.orders.first.id;

    // cart clear
    cart.clear();

    // Success screen
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(orderId: lastOrderId, total: total),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Order summary
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: const Text("Order Summary"),
                subtitle: Text("Items: ${cart.items.length}"),
                trailing: Text("৳${cart.totalAmount.toStringAsFixed(2)}"),
              ),
            ),

            // Address form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: "Phone"),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _addressCtrl,
                    decoration: const InputDecoration(labelText: "Address"),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _cityCtrl,
                    decoration: const InputDecoration(labelText: "City"),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? "Required" : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payment method
            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'COD',
                    groupValue: _paymentMethod,
                    onChanged: (v) => setState(() => _paymentMethod = v!),
                    title: const Text("Cash on Delivery"),
                  ),
                  const Divider(height: 0),
                  RadioListTile<String>(
                    value: 'Card',
                    groupValue: _paymentMethod,
                    onChanged: (v) => setState(() => _paymentMethod = v!),
                    title: const Text("Card (Demo)"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cart.items.isEmpty ? null : _placeOrder,
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
