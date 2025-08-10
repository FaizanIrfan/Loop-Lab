import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        prefixIcon:
            Icon(widget.prefixIcon, color: isDark ? AppColors.lightBackground : Color(0xFF00008B)), // Dark Blue
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: isDark ? AppColors.lightBackground : Color(0xFF00008B),), // Dark Blue border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: isDark ? AppColors.lightBackground : Color(0xFF00008B), width: 2), // Dark Blue
        ),
      ),
    );
  }
}
