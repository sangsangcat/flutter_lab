// import './outer.dart';
//같은 프로젝트 내에 있는 dart 파일을 import 할때.. 위에처럼 상대경로로 파일을 명시 가능..
//원한다면 같은 프로젝트 내의 dart 파일을 package 로 절대경로 명시 가능..
//절대 경로로 명시할 때.. 패키지명/ 가 지칭하는 위치는.. lib
import 'package:flutter_lab/ch2/section1/outer.dart';

void main() {
  no1 = 100;
  // _no2 = 200 //error..

  sayHello1();
  // _sayHello2(); //error..

  User1();
  // _User2(); //error..
}