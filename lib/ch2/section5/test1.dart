//함수 선언 위치.....................................
//top level...
void some1() {
  //함수 내에 함수 선언 가능..
  void some2() {}
}

class MyClass {
  //클래스 멤버 함수..
  void some() {}

  //오버로딩 지원하지 않는다..
  // void some(int a) {} //error..
}

//매개변수........................
void some2(int a) {}
//var 은 타입 유추 기법이다..
//대입되는 값에 의해 타입이 결정된다..
//매개변수가 var 로 선언하면.. 런타임 시점에 값이 대입되므로..선언하는 순간에 타입 결정이 안된다..
//dynamic 타입이 된다..
void some3(var a) {
  a = 10;
  a = 'hello';
  a = true;
}

//매개변수 선언시 타입, var 생략..dynamic
void some4(a) {
  a = 10;
  a = 'hello';
  a = true;
}

//return
void some5() {
  // return 10; //error..
  return; //ok.....
}

int some6() {
  return 10; //ok...
}

dynamic some7() {
  // return 10; //ok...
  // return 'hello'; //ok...
  return false; //ok...
}

//리턴과 관련된 표현을 생략한다..
//기본이 dynamic
some8() {
  return 'hello';
}
