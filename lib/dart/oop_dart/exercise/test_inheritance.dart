class A {
  // var num = 1;
  // var _value = "Parent Value";
  void doSomething() {
    print("class A");
  }
}

abstract class B {
  void doSomething();
}

class C extends A implements B {
  // var num = 2;
  // var _value = "Child Value";

  // String getValues() {
  //   return "C's value: $_value, Parent's value: ${super._value}";
  // }
  @override
  void doSomething() {
    print("interface B");
    super.doSomething();
  }
}

void main() {
  var c = C();
  c.doSomething();
  // print(c.num);
  // print(c.getValues());
}
