class A {
  late final String _testVal;
}

class B extends A {}

class C extends B {
  A a;

  C(this.a);
}

void main() {
  var a = A();
  var c = C(a);

  c._testVal = "Test Private Value";

  print(c._testVal);
}
