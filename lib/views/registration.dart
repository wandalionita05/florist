import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/views/common_widgets/appBar.dart';
import 'package:florist/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: MyAppBar(
        leading: InkResponse(
          onTap: () => Get.back(),
          child: const BackButtonIcon(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Get.theme.cardColor,
                  radius: 36,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Assets.imagesAppIcon,
                      scale: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Create your account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Register to start using the app",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _inputField(
                      label: "Full Name",
                      hint: "Farhan",
                      controller: nameController,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _inputField(
                      label: "Email",
                      hint: "example@gmail.com",
                      controller: emailController,
                      icon: Icons.email,
                      keyboard: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _passwordField(),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const StadiumBorder(),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi");
      return;
    }

    setState(() => isLoading = true);

    try {
      await AuthService().register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await Get.dialog(
        AlertDialog(
          title: const Text("Berhasil 🎉"),
          content: const Text("Register berhasil, silakan login."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text("OK"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      Get.snackbar(
        "Register gagal",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _inputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Get.theme.primaryColor),
            filled: true,
            fillColor: Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: "••••••••",
            prefixIcon: Icon(Icons.lock, color: Get.theme.primaryColor),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
            filled: true,
            fillColor: Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
