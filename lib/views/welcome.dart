import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/views/registration.dart';
import 'package:florist/views/common_widgets/appBar.dart'; 

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage(Assets.imagesWelcomeBg),
            fit: BoxFit.cover,
          ))),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 44,
                  ),
                  CircleAvatar(
                    backgroundColor: Get.theme.cardColor,
                    radius: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Assets.imagesAppIcon,
                        scale: 4.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(

                        "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(

                      "Use your email and password to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Get.theme.colorScheme.primary,
                          ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // EMAIL
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // PASSWORD
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: login API
                        Get.snackbar("Info", "Login clicked");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: StadiumBorder(),
                      ),
                      child: Text("Login", style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // REGISTER LINK
                  GestureDetector(
                    onTap: () => Get.to(() => RegistrationScreen()),
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
