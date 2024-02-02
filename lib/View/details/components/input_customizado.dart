import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {
  const InputCustomizado({
    Key? key,
    required this.hint,
    this.obscure = false,
    this.icon = const Icon(Icons.person),
    required this.controller, // Add this line
  }) : super(key: key);

  final String hint;
  final bool obscure;
  final Icon icon;
  final TextEditingController controller; // Add this line

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextField(
        controller: controller, // Use the provided controller here
        obscureText: obscure,
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
