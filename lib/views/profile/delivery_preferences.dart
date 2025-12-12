import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/domain/delivery_preferences_controller.dart';

class DeliveryPreferencesPage extends StatelessWidget {
  const DeliveryPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryPreferencesController controller =
        Get.find<DeliveryPreferencesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Preferences"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== DELIVERY TIME =====
            const Text(
              "Preferred Delivery Time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Obx(() => DropdownButtonFormField<String>(
                  value: controller.deliveryTime.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Morning',
                        child: Text("Morning (08.00 - 12.00)")),
                    DropdownMenuItem(
                        value: 'Afternoon',
                        child: Text("Afternoon (12.00 - 17.00)")),
                    DropdownMenuItem(
                        value: 'Evening',
                        child: Text("Evening (17.00 - 21.00)")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateDeliveryTime(value);
                    }
                  },
                )),

            const SizedBox(height: 24),

            /// ===== CONTACTLESS =====
            Obx(() => SwitchListTile(
                  title: const Text("Contactless Delivery"),
                  subtitle:
                      const Text("Courier will leave the order at your door"),
                  value: controller.contactlessDelivery.value,
                  onChanged: controller.toggleContactless,
                )),

            const SizedBox(height: 16),

            /// ===== NOTES =====
            const Text(
              "Delivery Notes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Example: Leave near the security post",
                border: OutlineInputBorder(),
              ),
              onChanged: controller.updateNotes,
            ),

            const SizedBox(height: 32),

            /// ===== SAVE BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "Saved",
                    "Delivery preferences updated",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text("Save Preferences"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
