import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Title("1. Introduction"),
            _Text(
              "Welcome to Florist App. By using this application, you agree "
              "to comply with and be bound by these Terms & Conditions.",
            ),
            _Title("2. User Responsibilities"),
            _Text(
              "You are responsible for maintaining the confidentiality "
              "of your account information.",
            ),
            _Title("3. Orders & Delivery"),
            _Text(
              "Delivery times are estimates and may vary depending "
              "on external factors.",
            ),
            _Title("4. Payments"),
            _Text(
              "All payments must be completed before processing orders.",
            ),
            _Title("5. Refund Policy"),
            _Text(
              "Refunds are subject to review and approval.",
            ),
            _Title("6. Privacy Policy"),
            _Text(
              "We respect your privacy and protect your personal data.",
            ),
            _Title("7. Changes"),
            _Text(
              "We reserve the right to modify these terms at any time.",
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                "Last updated: August 2025",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  const _Text(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.5),
    );
  }
}
