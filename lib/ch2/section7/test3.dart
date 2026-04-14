class MyClass {
  // 자동으로 객체 생성이 안된다.. 꼭 코드에서 객체를 생성해서 리턴해야 한다.
  // factory MyClass(){ }

  MyClass._instance();

  factory MyClass(){
    //null 리턴 시킬 수 없다..
    // return null; //error..
    //클래스 타입의 객체만 리턴 가능..
    // return 'hello'; //error..

    //자신의 클래스 타입의 객체를 준비해서 리턴...
    return MyClass._instance();
  }
}

//singleton 구현.....
//어느 클래스의 객체가 단 하나만 생성되어 이용되게...
class MySingleton {
  static final MySingleton _instance = MySingleton._internal();

  MySingleton._internal();

  factory MySingleton(){
    return _instance;
  }
}

//캐싱 알고리즘...
//이 클래스 객체가 생성되면서 이미지 로딩이 되어야 하는데 퍼포먼스에 부담되는 작업이다..
//신규 이미지는 작업을 통해 새로운 객체 생성..
//기존의 이미지는 캐싱했다가.. 작업 없이 그대로 이용하게..
class Image {
  late String url;

  static Map<String, Image> _cache = <String, Image> {};

  Image._instance(this.url);

  factory Image(String url){
    if(_cache[url] == null){
      //캐싱된 것이 없다..
      var obj = Image._instance(url);
      _cache[url] = obj;
    }
    return _cache[url]!;
  }
}

//const constructor................
class MyClass2 {
  //이 클래스내에 const 생성자가 있다면.. 이 클래스의 모든 멤버 변수는 final 로 선언..
  final int data;
  const MyClass2(this.data);
}


main(){
  MyClass();

  var obj1 = MySingleton();
  var obj2 = MySingleton();
  print(obj1 == obj2); //false

  var image1 = Image('a.jpg');
  var image2 = Image('a.jpg');
  print(image1 == image2); //true
  var image3 = Image('b.jpg');
  print(image1 == image3); //false

  //객체 두번 생성, 동일 매개변수로..
  //==> 객체가 두개 생성되었다..
  var obj3 = MyClass2(10);
  var obj4 = MyClass2(10);
  print(obj3 == obj4); //false

  var obj5 = const MyClass2(10);
  var obj6 = const MyClass2(10);
  print(obj5 == obj6); //true

  var obj7 = const MyClass2(10);
  var obj8 = const MyClass2(20);
  print(obj7 == obj8); //false
}