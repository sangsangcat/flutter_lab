main() {
  //List...................
  //선언과 동시에 값 지정이 가능한 경우...............
  List<int> list1 = [10, 20, 30];
  list1[0] = 100;
  list1.add(40); //size 가변...
  list1.removeAt(1);
  print(list1); //[100, 30, 40]

  //배열처럼 사이즈를 고정으로 쓰고 싶다..
  //filled() 라는 생성자를 이용한다..
  var list2 = List<int>.filled(3, 0); //size - 초기값...
  print(list2); //[0, 0, 0]
  list2[0] = 10;
  print(list2); //[10, 0, 0]
  // list2.add(40); //runtime error : Unsupported operation: Cannot add to a fixed-length list

  //size 가변으로 사용하는 경우...
  var list3 = List<int>.filled(3, 0, growable: true);
  list3.add(40);
  print(list3); //[0, 0, 0, 40]

  //초기값을 함수로..함수가 실행되고 결과값으로..generate 라는 생성자 이용..
  var list4 = List<int>.generate(3, (index) => index + 10, growable: true);
  print(list4); //[10, 11, 12]

  Map<String, String> map1 = {"one": "hello", "two": "world"};
  print(map1["one"]); //hello
  map1["two"] = "aaa";
  print(map1); //{one: hello, two: aaa}

  Iterator<int> iterator = list1.iterator;
  while (iterator.moveNext()) {
    print(iterator.current);
  }
}
