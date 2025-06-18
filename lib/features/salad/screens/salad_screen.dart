import 'package:flutter/material.dart';

class SaladScreen extends StatelessWidget {
  const SaladScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Salad")],
        ),
      ),
    );
  }
}
