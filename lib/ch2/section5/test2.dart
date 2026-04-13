main() {
  //{} 로 옵셔널로 선언하는 것은 하나의 함수에서 한번만..
  // void some1({int data1}, {String data2, bool data3}){} //error..

  //{} 로 묶이는 매개변수는 함수 매개변수중 마지막에 위치..
  // void some1({int data1, String data2}, bool data3){} //error..

  //한번만.. 마지막 위치에.. {}로 선언했다..
  //{} 로 매개변수가 선언되어 있다면.. 호출시에 값이 대입이 안될 수 있다..
  //dart 는 null safety 를 지원한다.. 대입이 안된다면 null 인데.. 타입이 맞지 않아서..
  // void some1(int data1, {String data2, bool data3}) {}

  //nullable 로 선언하던가..기본값을 대입하던가..
  void some1(int data1, {String? data2, bool data3 = false}) {}

  some1(10);
  //named parameter 로 선언된 매개변수 값을 지정하려면 꼭 이름을 명시해야 한다..
  // some1(10, 'hello', true); //error...
  some1(10, data2: "hello");
  some1(10, data3: true);
  some1(10, data2: "hello", data3: true);
  //이름이 명시되므로 순서는 의미가 없다..
  some1(10, data3: true, data2: "hello");

  //required...................
  //모두 필수 매개변수..모두 순서를 맞추어서 호출해야 한다..
  void some2(int arg1, String arg2, bool arg3) {}
  some2(10, "hello", true);

  //필수 이지만...순서를 고려하지 않고 호출이 가능해서...
  void some3({required int arg1, required String arg2, required bool arg3}) {}
  some3(arg1: 10, arg3: true, arg2: "hello");

  //positional parameter.............
  void some4(int data1, [String? data2, bool data3 = true]) {}

  some4(10);
  some4(10, "hello");
  // some4(10, true); //error..
  // some4(10, data3: true); //error...
  some4(10, "hello", true);
}
