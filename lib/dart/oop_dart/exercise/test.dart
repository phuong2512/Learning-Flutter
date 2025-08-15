// class A{
//   final int val1 = 1;
// }
//
// class B extends A {
//   final int val1 = 5;
//   final int val2 = 2;
// }
//
// void main(){
//   var b = B();
//   print("${b.val1}, ${b.val2}");
// }

class A {
  void doSomething() {
    print("class A");
  }
}

class B {
  void doSomething() {
    print("class B");
  }
}

class C extends A implements B {
  // @override
  // void doSomething() {
  //   print("class C");
  // }
}

void main() {
  var c = C();
  c.doSomething();
}
