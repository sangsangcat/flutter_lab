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

  //method channel...........
  String? methodResultData;
  String? methodReceiveData;


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

  //method channel..............
  Future<Null> methodCall() async {
    const methodChannel = MethodChannel('myMethodChannel');
    try{
      //native call...
      Map result = await methodChannel.invokeMethod('oneMethod', {'data1':'kim', 'data2':'lee'});
      setState(() {
        methodResultData = "${result['one']}, ${result['two']}";
      });

      methodChannel.setMethodCallHandler((call) async {
        switch(call.method){
          case 'twoMethod':
            setState(() {
              methodReceiveData = 'receive : ${call.arguments}';
            });
            return 'Reply from Dart';
        }
      });
    }catch(e){
      print('error : $e');
    }
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
            Text('method channel, result : $methodResultData'),
            Text('method channel, receive : $methodReceiveData'),
            ElevatedButton(onPressed: methodCall, child: Text('method channel')),
          ],
        ),
      ),
    );
  }
}