import 'package:flutter/material.dart';

class ManageAddressesScreen extends StatelessWidget {
  const ManageAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Addresses")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Enter Address"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Address Saved: ${addressController.text} ✅"),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Save Address"),
            ),
          ],
        ),
      ),
    );
  }
}
