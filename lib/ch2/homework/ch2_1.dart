int plus({int no1 = 0, int no2 = 0, int no3 = 0}) {
  return no1 + no2 + no3;
}

int square(int n) => n * n;

String _name = "";

String get name => _name;

set name(String value) {
  _name = value.trim()[0].toUpperCase() + value.trim().substring(1);
}

void main() {
  print("plus result : ${plus()}");
  print("plus result : ${plus(no1: 10, no2: 20)}");
  print("plus result : ${plus(no1: 10, no2: 20, no3: 30)}");

  print("square result : ${square(10)}");

  name = "hong";
  print("name : $name");
}
