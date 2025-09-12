import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  // Email launch function
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@megamart.com',
      query: 'subject=App Support&body=Hello, I need help with...',
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch $emailUri');
    }
  }

  // Phone launch function
  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+880123456789');
    if (!await launchUrl(phoneUri)) {
      throw Exception('Could not launch $phoneUri');
    }
  }

  // Feedback launch function (email feedback)
  Future<void> _launchFeedback() async {
    final Uri feedbackUri = Uri(
      scheme: 'mailto',
      path: 'feedback@megamart.com',
      query: 'subject=App Feedback&body=Your suggestions...',
    );
    if (!await launchUrl(feedbackUri)) {
      throw Exception('Could not launch $feedbackUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "FAQ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("How to place an order?"),
              leading: const Icon(Icons.question_answer, color: Colors.orange),
            ),
            ListTile(
              title: const Text("Payment failure issues"),
              leading: const Icon(Icons.payment, color: Colors.orange),
            ),
            ListTile(
              title: const Text("Delivery timeline"),
              leading: const Icon(Icons.local_shipping, color: Colors.orange),
            ),
            const Divider(height: 30),

            const Text(
              "Contact Options",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.orange),
              title: const Text("Email Support"),
              onTap: _launchEmail,
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.orange),
              title: const Text("Phone Support"),
              onTap: _launchPhone,
            ),
            ListTile(
              leading: const Icon(Icons.feedback, color: Colors.orange),
              title: const Text("Feedback / Suggestions"),
              onTap: _launchFeedback,
            ),

            const SizedBox(height: 20),
            const Text(
              "Live Chat (Coming Soon)",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
