import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

//dto class
class Post {
  int id;
  String title;
  String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }
}

class MyAppState extends State<MyApp> {
  Post? post = null;

  onPressGet() async {
    try {
      http.Response response = await http
          .get(
            Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
            headers: {
              'User-Agent':
                  'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 '
                  '(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
              'Accept': 'application/json',
            },
          )
          .timeout(Duration(seconds: 10));

      print('status code : ${response.statusCode}');

      setState(() {
        post = Post.fromJson(jsonDecode(response.body));
      });
    } on TimeoutException catch (e) {
      print('timeout : $e');
    } catch (e) {
      print('error : $e');
    }
  }

  onPressPost() async {
    try {
      http.Response response = await http
          .post(
            Uri.parse('https://jsonplaceholder.typicode.com/posts'),
            body: {'title': 'hello', 'body': 'world', 'userId': '1'},
          )
          .timeout(Duration(seconds: 10));

      print('status code : ${response.statusCode}');

      setState(() {
        post = Post.fromJson(jsonDecode(response.body));
      });
    } on TimeoutException catch (e) {
      print('timeout : $e');
    } catch (e) {
      print('error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('http test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('id : ${post?.id}, title : ${post?.title}, ${post?.body}'),
              ElevatedButton(onPressed: onPressGet, child: Text('get')),
              ElevatedButton(onPressed: onPressPost, child: Text('post')),
            ],
          ),
        ),
      ),
    );
  }
}
