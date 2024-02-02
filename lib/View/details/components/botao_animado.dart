import 'package:flutter/material.dart';

class BotaoAnimado extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> largura;
  final Animation<double> altura;
  final Animation<double> radius;
  final Animation<double> opacidade;
  final VoidCallback onPressed;
  final String buttonText; // Add this line

  BotaoAnimado({
    Key? key,
    required this.controller,
    required this.onPressed,
    required this.buttonText, // Add this line
  })   : largura = Tween<double>(
    begin: 0,
    end: 500,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5),
    ),
  ),
        altura = Tween<double>(
          begin: 0,
          end: 50,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.7),
          ),
        ),
        radius = Tween<double>(
          begin: 0,
          end: 20,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0),
          ),
        ),
        opacidade = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: largura.value,
        height: altura.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.value),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 100, 127, 1),
              Color.fromRGBO(255, 123, 145, 1),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: opacidade,
            child: Text( // Use the provided buttonText
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
