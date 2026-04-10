//var... dynamic...
class User {}

main() {
  //선언과 동시에 타입 지정.. 타입에 맞는 데이터만 할당 가능..
  int data1 = 10;
  // data1 = "hello"; //error
  // data1 = 10.0; //error

  // var 은 타입 유추 기법이다..  선언하는 라인에서 대입되는 값에 의해 타입이 고정.
  var data2 = 10;
  // data2 = "hello"; //error..
  // data2 = 10.0; //error..

  //모든 타입의 데이터...
  dynamic data3 = 10;
  data3 = "hello"; //ok..
  data3 = 10.0; //ok..
  data3 = User(); //ok..

  //타입 유추 기법이다.. 대입되는 값으로 타입이 고정된다..
  //값 대입을 하지 않았다.. 유추할 수 없다.. dynamic 타입으로 유추한다..
  var data4;
  data4 = 10;
  data4 = 10.0;
  data4 = "hello";
}
