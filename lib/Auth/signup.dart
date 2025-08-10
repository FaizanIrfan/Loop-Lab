import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:loop_lab/Auth/auth_service.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/Widgets/input_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneNumberController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "< Back",
                  style: TextStyle(color: isDark ? AppColors.lightBackground : Color(0xFF00008B),),
                ),
              ),
              const SizedBox(height: 50),
              // Logo + Name in one line
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.all_inclusive,
                      size: 60,
                      color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                    ),
                    Text(
                      " | ",
                      style: TextStyle(fontSize: 34, color: isDark ? AppColors.lightBackground : Color(0xFF00008B),),
                    ),
                    Text(
                      "LoopLab",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up text
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                ),
              ),
              const SizedBox(height: 25),

              // Full name
              InputField(
                hintText: "Full Name",
                prefixIcon: Icons.person,
                controller: fullNameController,
              ),
              const SizedBox(height: 20),

              // Email
              InputField(
                hintText: "Email",
                prefixIcon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 20),

              // Password
              InputField(
                hintText: "Password",
                prefixIcon: Icons.lock,
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),

              // Phone number
              InputField(
                hintText: "Phone no",
                prefixIcon: Icons.phone,
                controller: phoneNumberController,
              ),
              const SizedBox(height: 25),

              // Signup button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    final fullName = fullNameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final phoneNumber = phoneNumberController.text.trim();
                    signUpUser(email, password, fullName, phoneNumber, context);
                  },

                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Spacer(),

              // Footer
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Signin",
                        style: TextStyle(
                          color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
