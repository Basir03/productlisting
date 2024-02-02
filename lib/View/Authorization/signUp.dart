import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../details/components/botao_animado.dart';
import '../details/components/input_customizado.dart';
import '../home/home_screen.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> with SingleTickerProviderStateMixin {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  late AnimationController _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animacaoBlur = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _animacaoBlur!,
              builder: (context, widget) {
                return Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/fundo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: _animacaoBlur!.value,
                      sigmaY: _animacaoBlur!.value,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          child: FadeTransition(
                            opacity: _animacaoFade!,
                            child: Image.asset("assets/images/detalhe1.png"),
                          ),
                        ),
                        Positioned(
                          left: 50,
                          child: FadeTransition(
                            opacity: _animacaoFade!,
                            child: Image.asset("assets/images/detalhe2.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animacaoSize!,
                    builder: (context, widget) {
                      return Container(
                        width: _animacaoSize?.value,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 80,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            InputCustomizado(
                              hint: 'name',
                              obscure: false,
                              icon: const Icon(Icons.person),
                              controller:
                                  _nameController, // Pass the controller here
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                            ),
                            InputCustomizado(
                              hint: 'email',
                              obscure: false,
                              icon: const Icon(Icons.email),
                              controller:
                                  _emailcontroller, // Pass the controller here
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                            ),
                            InputCustomizado(
                              hint: 'password',
                              obscure: true,
                              icon: const Icon(Icons.lock),
                              controller:
                                  _passwordController, // Pass the controller here
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BotaoAnimado(
                    buttonText: "SignUp",
                    controller: _controller,
                    onPressed: () {
                      _addData();
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addData() async {
    try {
      if (_nameController.text.isNotEmpty &&
          _emailcontroller.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;

        String employeeId = timestamp.toString();

        await FirebaseFirestore.instance
            .collection('employees')
            .doc(employeeId)
            .set({
          'employeeId': employeeId,
          'name': _nameController.text.trim(),
          'email': _emailcontroller.text.trim(),
          'password': _passwordController.text.trim(),
          // Add more fields as needed
        });
        Fluttertoast.showToast(
          msg: "Sign up successfully",
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Fill the field",
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding data: $e');
      }
    }
  }
}
