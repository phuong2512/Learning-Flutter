abstract class Base {
  late final String prop1;
  late final int prop2;

  Base(this.prop1, this.prop2);

  String getProp() {
    return "'$prop1' và $prop2";
  }

  void doSomething();
}

class A extends Base {
  A(super.prop1, super.prop2);

  @override
  void doSomething() {
    print("Class A có 2 thuộc tính với giá trị lần lượt là: ${getProp()}");
  }
}

class B extends Base {
  B(super.prop1, super.prop2);

  @override
  void doSomething() {
    print("Class B có 2 thuộc tính với giá trị lần lượt là: ${getProp()}");
  }
}

void main() {
  var a = A("A", 1);
  var b = B("B", 2);

  a.doSomething();
  b.doSomething();
}
