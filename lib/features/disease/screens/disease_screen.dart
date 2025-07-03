import 'package:flutter/material.dart';
import 'package:saladappv2_flutter/util/style.dart';

class DiseaseScreen extends StatelessWidget {
  const DiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Disease", style: robotoBlack.copyWith(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
