import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/domain/user_controller.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final UserController userController = Get.find<UserController>();

  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController addressCtrl;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController(text: userController.name.value);
    emailCtrl = TextEditingController(text: userController.email.value);
    phoneCtrl = TextEditingController(text: userController.phone.value);
    addressCtrl = TextEditingController(text: userController.address.value);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// ================= NAME =================
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ================= EMAIL =================
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ================= PHONE =================
                    TextField(
                      controller: phoneCtrl,
                      decoration: const InputDecoration(
                        labelText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ================= ADDRESS =================
                    TextField(
                      controller: addressCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Address",
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 28),

                    /// ================= SAVE BUTTON =================
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          /// UPDATE DATA
                          userController.updateUser(
                            name: nameCtrl.text,
                            email: emailCtrl.text,
                            phone: phoneCtrl.text,
                            address: addressCtrl.text,
                          );

                          /// LANGSUNG KELUAR
                          Get.back();

                          /// SNACKBAR MUNCUL DI HALAMAN PROFILE
                          Get.snackbar(
                            "Saved",
                            "Profile updated successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                          );
                        },
                        child: const Text(
                          "Save",
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
