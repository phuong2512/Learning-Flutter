class Person {
  String name; // Public
  int age; // Public

  Person(this.name, this.age);

  void sayHello() {
    // Public
    print("Hello, I'm $name");
  }
}

void main() {
  var person = Person("Alice", 30);
  print(person.name); // In: Alice (truy cập từ bên ngoài class)
  person.sayHello(); // In: Hello, I'm Alice
}
