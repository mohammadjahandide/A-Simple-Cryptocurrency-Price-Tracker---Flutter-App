import 'package:cryptocurrency_price_tracker/price_screen.dart';
import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp(StartScreen());
}

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: PriceScreen(),
    );
  }
}

