import 'package:assigment/pages/HomeScreen.dart';
import 'package:flutter/material.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Navigate to home screen after 3 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash.png',
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
