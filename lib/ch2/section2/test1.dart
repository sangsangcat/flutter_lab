//const(compile time) vs final(runtime)............
//top level 에 선언되는 상수 변수...
//선언과 동시에 초기값 대입해야 한다..
const String data1 = "hello";
final int data2 = 10;

class User {
  //object member 를 const 로 상수변수로 만들 수 없다..
  //런타임 시점에 값 변경이 안되므로.. 매번 객체 생성시에 동일한 값을 가지는 메모리가 확보되지 못하도록...
  // const String data1 = "hello";
  //static member 는 const 선언 가능.. 어짜피.. 메모리 한번만 확보.. 그 곳의 값을 고정..상수로..
  static const String data1 = "hello";

  //선언과 동시에 값을 대입하지는 않았다..코드가 실행되어야 값이 대입된다.. 상수변수다..런타임 시점의 상수변수
  final int data2;
  //생성자... 생성자 매개변수로 멤버변수 초기화 구문...
  User(this.data2);

  void some() {
    const String data3 = "hello";
    //선언하는 라인에서 초기값을 지정하지 않아도 된다..
    //코드가 실행되면서 초기값 대입 가능하다..
    //한번 대입되면 값 변경은 불가하다..
    final int data4;
    data4 = 10;
    // data4 = 50; //error...

    int age = 10;
    String str1 = "$data1, $data2, $age"; //ok..
    final String str2 = "$data1, $data2, $age"; //ok..
    // const String str3 = "$data1, $data2, $age"; //error,,,
  }
}

main() {
  //error.....
  // data1 = "world";
  // data2 = 20;
}
