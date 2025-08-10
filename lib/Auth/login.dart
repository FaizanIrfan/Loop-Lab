import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:loop_lab/Auth/auth_service.dart';
import 'package:loop_lab/Auth/signup.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/Widgets/input_field.dart';
import 'package:loop_lab/Widgets/social_button.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + Name in one line
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.all_inclusive,
                          size: 50,
                          color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                        ),
                        Text(
                          " | ",
                          style: TextStyle(
                            fontSize: 28,
                            color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                          ),
                        ),
                        Text(
                          "LoopLab",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.lightBackground : Color(0xFF00008B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign In text
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),

                  // Email field
                  InputField(
                    hintText: "Email",
                    prefixIcon: Icons.email,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),

                  // Password field
                  InputField(
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 10),

                  // Forget password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(color: isDark ? AppColors.lightBackground : Color(0xFF00008B)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Sign In button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        loginUser(email, password, context);
                      },

                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(child: Text("or sign in with")),
                  const SizedBox(height: 15),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(icon: Icons.g_mobiledata, color: Colors.red),
                      SocialButton(icon: Icons.facebook, color: Colors.blue),
                      SocialButton(icon: Icons.close, color: Colors.black),
                      SocialButton(
                        icon: Icons.business,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  // Footer
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Signup",
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
        ),
      ),
    );
  }
}
