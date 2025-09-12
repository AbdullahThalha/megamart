import 'package:flutter/material.dart';

import 'change_password_screen.dart';
import 'delete_account_screen.dart';
import 'edit_profile_screen.dart';
import 'manage_addresses_screen.dart';
import 'update_email_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.orange),
            title: const Text("Change Password"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.email, color: Colors.orange),
            title: const Text("Update Email"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpdateEmailScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.person, color: Colors.orange),
            title: const Text("Edit Profile Info"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.orange),
            title: const Text("Manage Addresses"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ManageAddressesScreen(),
                ),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text("Delete Account"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DeleteAccountScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
