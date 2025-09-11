import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  const PaymentScreen({super.key, required this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  @override
  void dispose() {
    _cardCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  Future<void> _payNow() async {
    if (!_formKey.currentState!.validate()) return;

    // এখানে real gateway হলে API call হতো।
    await Future.delayed(const Duration(seconds: 1)); // demo delay

    if (!mounted) return;
    Navigator.pop(context, true); // success → true
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment (Demo)")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Payable Amount"),
              trailing: Text("৳${widget.amount.toStringAsFixed(2)}"),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Card Number (demo)",
                    ),
                    validator: (v) =>
                        (v == null || v.length < 8) ? "Invalid card" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _cvvCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "CVV (demo)"),
                    validator: (v) =>
                        (v == null || v.length < 3) ? "Invalid CVV" : null,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _payNow,
                child: const Text("Pay Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
