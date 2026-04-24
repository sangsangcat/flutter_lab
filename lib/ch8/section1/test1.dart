import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCall() async {
    BasicMessageChannel<String> channel = BasicMessageChannel('myMessageChannel', StringCodec());
    //native 에 메시지 전달..
    String? result = await channel.send('Hello from Dart');

    setState(() {
      resultMessage = result;
    });

    //native 의 message 수신..
    channel.setMessageHandler((String? message) async {
      setState(() {
        receiveMessage = message; //native 에서 전달 받은 데이터..
      });
      return 'Reply from Dart';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Platform Channel Test'),),
        body: Column(
          children: [
            Text('message channel, result : $resultMessage'),
            Text('message channel, receive : $receiveMessage'),
            ElevatedButton(onPressed: nativeCall, child: Text('message channel')),
          ],
        ),
      ),
    );
  }
}