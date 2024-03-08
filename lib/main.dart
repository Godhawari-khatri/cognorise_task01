import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    //if value is AC

    if (value == "AC") {
      //reset
      input = '';
      output = '';
    } else if (value == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel(); //initialization of Context Model
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark background color
      body: Column(
        children: [
          //input output area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white, // Text color
                    ),
                  ),
                  const SizedBox(
                    //to add space
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7), // Output text color
                    ),
                  ),
                  const SizedBox(
                    //to add space
                    height: 30,
                  )
                ],
              ),
            ),
          ),

          //buttons area,
          Row(
            children: [
              button(
                text: "AC",
                buttonbgColor: Colors.redAccent, // AC button color
                tColor: Colors.white,
              ),
              button(
                text: "<-",
                buttonbgColor: Colors.redAccent, // Backspace button color
                tColor: Colors.white,
              ),
              button(text: "", buttonbgColor: Colors.transparent),
              button(
                text: "/",
                buttonbgColor: Colors.blueAccent, // Division button color
                tColor: Colors.white,
              ),
            ],
          ),

          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "x",
                buttonbgColor: Colors.blueAccent, // Multiplication button color
                tColor: Colors.white,
              ),
            ],
          ),

          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonbgColor: Colors.blueAccent, // Subtraction button color
                tColor: Colors.white,
              ),
            ],
          ),

          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                text: "+",
                buttonbgColor: Colors.blueAccent, // Addition button color
                tColor: Colors.white,
              ),
            ],
          ),

          Row(
            children: [
              button(
                text: "%",
                buttonbgColor: Colors.blueAccent, // Percentage button color
                tColor: Colors.white,
              ),
              button(text: "0"),
              button(text: "."),
              button(
                text: "=",
                buttonbgColor: Colors.redAccent, // Equal button color
                tColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.white,
    buttonbgColor = Colors.grey, // Default button color
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(22),
            primary: buttonbgColor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
