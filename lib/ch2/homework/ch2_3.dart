mixin Describable {
  String get description;

  String describe();

  String shortDescription(){
    return "[${describe()}]";
  }
}

class Animal {
  final String name;
  final int age;

  Animal(this.name, this.age);

  String sound() => "...";

  @override
  String toString(){
    return "Animal(name=$name, age=$age)";
  }
}

class Dog extends Animal with Describable {
  final String breed;

  Dog(String name, int age, this.breed): super(name, age);

  Dog.mixed(String name, int age): this(name, age, "믹스견");

  Dog.unknown(String name): this(name, 0, "알 수 없음");

  @override
  String sound() => "멍멍!";

  @override
  String get description => "$name | $breed | $age 살";

  @override
  String describe() => "강아지 $name (품종: $breed)";
}