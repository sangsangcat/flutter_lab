import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Counter')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Counter()],
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<Counter> createState() {
    return CounterState();
  }
}

class CounterState extends State<Counter> {
  int count = 0;

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(onPressed: incrementCounter, child: Text('증가')),
      ],
    );
  }
}
