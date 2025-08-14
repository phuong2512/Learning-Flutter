class Animal {
  String name;

  Animal(this.name);

  void describe() {
    print("This is an animal named $name");
  }


}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void describe() {
    super.describe(); // Gọi phương thức của lớp cha
    print("This is a dog");
  }
}


mixin Flyable {
  void fly() => print("Flying");
  void land() => print("Landing");
}

class Bird extends Animal with Flyable {
  Bird(String name) : super(name);
}

void main() {
  // var dog = Dog("Max");
  // dog.describe();
  // In:
  // This is an animal named Max
  // This is a dog

  var bird = Bird("Tweety");
  bird.fly(); // In: Flying
  bird.land();
  print(bird.name); // In: Tweety
}