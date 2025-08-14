class Person {
  late int age; // Khai báo late

  void setName(int value) {
    age = value; // Khởi tạo muộn
  }
}

void main() {
  var person = Person();
  person.setName(15);
  print(person.age); // In: Alice
  person.age = 17;
  print(person.age);
}