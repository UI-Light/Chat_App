import 'dart:async';
import 'package:chat_app2/views/ui/login_screen.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) {
            return const LoginScreen();
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'ChatApp',
        style: GoogleFonts.abel(
            fontSize: 70,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Colors.black,
                  Colors.deepPurple,
                ],
              ).createShader(
                const Rect.fromLTWH(0.0, 0.0, 250.0, 100.0),
              )),
      )),
    );
  }
}
