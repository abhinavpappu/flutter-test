import 'package:flutter/material.dart';

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
          Row(
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    controller: fieldController,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                    style: TextStyle(
                      fontSize: 48,
                      height: 1.25
                    ),
                  ),
                  padding: EdgeInsets.only(right: 16)
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.backspace),
                  onPressed: () {
                    final text = fieldController.text;
                    if (text.length > 0) {
                      fieldController.text = text.substring(0, text.length - 1);
                    }
                  },
                ),
                padding: EdgeInsets.only(right: 16),
              )
            ],
          ),
          CalculatorNumberButtons(
            onTap: (buttonValue) {
              fieldController.text += buttonValue;
            },
          ),
        ],
      ),
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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 36
            ),
          )
        ),
        onTap: () {
          onTap(text);
        },
      ),
    );
  }
}