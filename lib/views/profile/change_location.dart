import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/domain/location_controller.dart';

class ChangeLocationPage extends StatefulWidget {
  const ChangeLocationPage({Key? key}) : super(key: key);

  @override
  State<ChangeLocationPage> createState() => _ChangeLocationPageState();
}

class _ChangeLocationPageState extends State<ChangeLocationPage> {
  final LocationController locationController = Get.find<LocationController>();

  late TextEditingController addressCtrl;
  late TextEditingController cityCtrl;
  late TextEditingController notesCtrl;

  @override
  void initState() {
    super.initState();

    addressCtrl =
        TextEditingController(text: locationController.addressLine.value);
    cityCtrl = TextEditingController(text: locationController.city.value);
    notesCtrl = TextEditingController(text: locationController.notes.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Location"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: addressCtrl,
                      decoration: const InputDecoration(
                        labelText: "Address",
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: cityCtrl,
                      decoration: const InputDecoration(
                        labelText: "City",
                        prefixIcon: Icon(Icons.location_city),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: notesCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Address Notes",
                        hintText: "e.g. Near mosque, green gate",
                        prefixIcon: Icon(Icons.notes),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          locationController.updateLocation(
                            addressLine: addressCtrl.text,
                            city: cityCtrl.text,
                            notes: notesCtrl.text,
                          );

                          Get.snackbar(
                            "Saved",
                            "Location updated successfully",
                            snackPosition: SnackPosition.BOTTOM,
                          );

                          Get.back();
                        },
                        child: const Text(
                          "Save Location",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
