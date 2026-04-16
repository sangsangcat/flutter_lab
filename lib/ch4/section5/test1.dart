import 'package:flutter/material.dart';
import 'package:flutter_lab/ch4/section5/widgets/content_widget.dart';
import 'package:flutter_lab/ch4/section5/widgets/header_widget.dart';
import 'package:flutter_lab/ch4/section5/widgets/icon_widget.dart';
import 'package:flutter_lab/ch4/section5/widgets/image_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Layout Test'),),
        body: Column(
          children: [
            HeaderWidget(),
            ImageWidget(),
            IconWidget(),
            ContentWidget(),
          ],
        ),
      ),
    );
  }
}