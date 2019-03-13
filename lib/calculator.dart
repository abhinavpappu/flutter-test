import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  final fieldController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          EntryField(fieldController: fieldController),
          CalculatorNumberButtons(onTap: buttonPressed),
        ],
      ),
    );
  }

  void buttonPressed(String value) {
    if (value == '=') {
      fieldController.text = evaluate(fieldController.text);
    } else if (fieldController.text == '0') {
      fieldController.text = value;
    } else {
      fieldController.text += value;
    }
  }

  String evaluate(String expression) {
    final p = Parser();
    final exp = p.parse(expression);
    double result = exp.evaluate(EvaluationType.REAL, ContextModel());
    return result.toString();
  }
}

class EntryField extends StatelessWidget {
  EntryField({Key key, @required this.fieldController}) : super(key: key);

  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              child: TextField(
                controller: fieldController,
                textAlign: TextAlign.end,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                style: TextStyle(fontSize: 48, height: 1.25),
              ),
              padding: EdgeInsets.only(right: 16)),
        ),
        InkResponse(
          child: Container(
            child: Icon(Icons.backspace),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(shape: BoxShape.circle),
          ),
          onTap: () {
            final text = fieldController.text;
            if (text.length > 0) {
              fieldController.text = text.substring(0, text.length - 1);
            }
          },
          onLongPress: () {
            fieldController.text = "";
          },
        ),
        Container(
          child: Text(' '),
          margin: EdgeInsets.only(left: 16),
        )
      ],
    );
  }
}

class CalculatorNumberButtons extends StatelessWidget {
  CalculatorNumberButtons({Key key, @required this.onTap}) : super(key: key);

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          getRow(['7', '8', '9', '+']),
          getRow(['4', '5', '6', '-']),
          getRow(['1', '2', '3', '/']),
          getRow(['0', '.', '=', '*']),
        ],
      ),
    );
  }

  Widget getRow(List<String> texts) {
    return Expanded(
      child: Row(
        children: texts.map(getButton).toList(),
      ),
    );
  }

  Widget getButton(String text) {
    return Expanded(
      child: InkWell(
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 36),
        )),
        onTap: () {
          onTap(text);
        },
      ),
    );
  }
}
