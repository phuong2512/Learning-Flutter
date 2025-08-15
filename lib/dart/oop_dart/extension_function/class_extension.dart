class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  String getDescription() {
    return "Name: $name";
  }
}

extension PersonExtension on Person {
  String getDescription() {
    return "Name: $name, Age: $age";
  }
}

void main() {
  var person = Person("Alice", 30);
  print(PersonExtension(person).getDescription()); // In: Name: Alice, Age: 30
  print(person.getDescription()); // In: Name: Alice
}
