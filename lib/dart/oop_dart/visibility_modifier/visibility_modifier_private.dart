// File: person.dart
class Person {
  final String _name; // Private

  Person(this._name);

  void _sayHello() {
    // Private
    print("Hello, I'm $_name");
  }

  void publicMethod() {
    _sayHello(); // Hợp lệ: truy cập private method trong cùng class
  }
}

void main() {
  var person = Person("Alice");
  print(person._name); // Hợp lệ: truy cập trong cùng file
  person._sayHello(); // Hợp lệ: truy cập trong cùng file
  person.publicMethod(); // In: Hello, I'm Alice
}
