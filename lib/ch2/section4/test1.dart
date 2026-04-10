int data1 = 10; //non-null
int? data2 = 10; //nullable

//top level, class member 변수를 선언하면서 선언과 동시에 초기값을 지정하지 않으려면...
//nullable 로 선언하거나.. late 예약어로 선언하거나..
// int data3; //error...
late int data3; //물론 꼭 사용하기 전에 초기화 해야 한다.. 그렇지 않으면 runtime error...

String? str = "hello";
List<int>? list = [10, 20, 30];

main() {
  //casting................
  //nullable 이 non-null 의 상위 타입니다..
  // data1 = data2; //nullable -> non null, //error....
  data1 = data2 as int; //ok.....
  data2 = data1; //non null -> nullable : 암시적 캐스팅..

  //late.....
  // print(data3); //LateInitializationError: Field 'data3' has not been initialized.
  data3 = 10;

  //! operator............
  data2!; //ok....
  data2 = null;
  // data2!; //runtime error..Null check operator used on a null value

  //?., ?[]... null 이 아니면 접근.. null 이면 전체 null
  // str.isEmpty; //error..nullable 로 선언된 객체의 멤버 접근은 ?.
  bool? result = str?.isEmpty;

  print(list?[0]);

  //??=...............오른쪽의 값이 null 이면 대입 연산을 실행시키지 마라.....
  int? data4;
  data4 ??= 10;
  print(data4);
  data4 ??= null;
  print(data4);

  //??...............null 인 경우의 대체...............
  String? data5 = "hello";
  String? result2 = data5 ?? "world";
  print(result2); // hello
  data5 = null;
  result2 = data5 ?? "world";
  print(result2); // world
}
