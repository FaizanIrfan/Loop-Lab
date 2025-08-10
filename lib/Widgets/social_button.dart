import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialButton({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
