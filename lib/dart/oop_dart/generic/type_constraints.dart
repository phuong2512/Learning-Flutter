abstract class Animal {
  void makeSound();
}

class Dog implements Animal {
  @override
  void makeSound() => print("Woof!");
}

class Cat implements Animal {
  @override
  void makeSound() => print("Meow!");
}

class Zoo<T extends Animal> {
  T animal;

  Zoo(this.animal);

  void makeAnimalSound() {
    animal.makeSound();
  }
}

void main() {
  var dogZoo = Zoo<Dog>(Dog());
  var catZoo = Zoo<Cat>(Cat());

  dogZoo.makeAnimalSound(); // In: Woof!
  catZoo.makeAnimalSound(); // In: Meow!
  // var stringZoo = Zoo<String>("Invalid"); // Lỗi: String không phải Animal
}