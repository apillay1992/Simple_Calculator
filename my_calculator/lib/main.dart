import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.tealAccent,
            title: const Center(
              child: Text(
                'My Calculator',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          body: const Calculator(),
        ));
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '0';
  double? firstOperand;
  String? operation;

  void buttonPressed(String text) {
    setState(() {
      if (text == 'C') {
        input = '0';
        firstOperand = null;
        operation = null;
      } else if (text == '←') {
        input = input.length > 1 ? input.substring(0, input.length - 1) : '0';
      } else if (['+', '-', '×', '÷'].contains(text)) {
        firstOperand = double.parse(input);
        operation = text;
        input = '0';
      } else if (text == '=') {
        double secondOperand = double.parse(input);
        input = performCalculation(firstOperand!, secondOperand).toString();
        firstOperand = null;
        operation = null;
      } else {
        input = (input == '0') ? text : input + text;
      }
    });
  }

  double performCalculation(double a, double b) {
    switch (operation) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b != 0 ? a / b : double.infinity; // Prevent division by zero
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: 350,
          width: double.infinity,
          alignment: Alignment.bottomRight,
          child: Text(
            input,
            style: const TextStyle(fontSize: 40),
          ),
        ),

        const SizedBox(
          height: 20.0,
          width: 200.0,
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              buildButtonRow(['C', '←', '÷', '×']),
              buildButtonRow(['7', '8', '9', '-']),
              buildButtonRow(['4', '5', '6', '+']),
              buildButtonRow(['1', '2', '3', '=']),
              buildButtonRow(['0', '.']),
            ],
          ),
        ),
      ],
    );
  }

  Row buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => buttonPressed(text),
              child: Text(
                text,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
