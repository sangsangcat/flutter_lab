//as 뒤의 Test1 은 이 파일내에서만.. 적용되는 별칭.. 개발자 임의 단어..
// import 'outer.dart' as Test1 show no1, sayHello1;
import 'outer.dart' as Test1 hide no1, sayHello1;

//dart 는 함수를 선언할 때 리턴과 관련된 표현을 생략할 수 있다..
//함수명이 main() 이면.. entry point..
main(){
  // Test1.no1 = 20;
  // Test1.sayHello1();
  Test1.User1 user1;
}