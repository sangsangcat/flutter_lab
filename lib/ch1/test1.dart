//현재의 파일이 아닌 외부 파일의 api 를 이용하려면 무조건 import...
//동일 폴더에 있는 외부 파일도.. import

//package 명이 flutter : flutter sdk 에서 공식 제공하는 패키지..
//material.dart : UI 가 출력되는 앱을 개발하기 위한 기본..
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp()); // 화면 출력하라.. 매개변수의 객체를...
}

// 화면을 구성하기 위한 개발자 클래스.. (통칭해서.. 위젯이라 부른다..)
class MyApp extends StatelessWidget {
  // 화면을 구성하기 위해서 자동 호출된다..
  // 이 함수에서 리턴시키는 것이 화면에 출력된다..
  @override
  Widget build(BuildContext context) {
    final word = WordPair.random();

    // 필수는 아니다.. 사실상의 필수이다..
    // 클래스의 객체 생성시에 new 예약어를 이용해도 되고.. 안해도 되고..
    return MaterialApp(
      home: Scaffold( // 화면의 기본 구조를 제공하는 사실상의 필수..
        appBar: AppBar(title: Text("package test"),),
        body: Center(
          child: Text('${word.first}'),
        ),
      ),
    );
  }

}