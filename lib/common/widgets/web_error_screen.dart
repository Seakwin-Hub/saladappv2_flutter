import 'package:flutter/material.dart';
import 'package:saladappv2_flutter/util/style.dart';

class WebErrorScreen extends StatelessWidget {
  const WebErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Web is not Supported!!",
        style: robotoBold.copyWith(
            fontSize: 30,
            color: Colors.blueGrey,
            decoration: TextDecoration.none),
      ),
    );
  }
}
