// 외부에서 import 해서 사용해야 하는 다트파일 가정..
int no1 = 10;

//dart 언어에서는 다른 언어에서 제공하는 접근제한자를 제공하지 않는다..
//public, private 등의 예약어가 없다..
// _ 를 이름 앞에 추가해서 private 개념 적용..
int _no2 = 20;

void sayHello1() {}

void _sayHello2() {}

class User1 {
  String? name;
  String? _address;
}

class _User2 { }

void main(){
  no1 = 100;
  _no2 = 200;

  sayHello1();
  _sayHello2();

  var obj1 = User1();
  obj1.name = "kim";
  obj1._address = "seoul";
  var obj2 = _User2();
}
