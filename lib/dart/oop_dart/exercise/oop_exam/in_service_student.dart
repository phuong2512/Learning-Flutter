import 'package:learning_flutter/dart/oop_dart/exercise/oop_exam/student.dart';

class InServiceStudent extends Student {
  final String a;

  InServiceStudent(
    super.studentId,
    super.name,
    super.age,
    super.studentClass,
    super.creditAccumulation,
    this.a,
  );

  @override
  void doSomething() {
    super.getInfo();
    print("Sinh viên hiện đang theo học lớp ${super.studentClass} hệ tại chức");
  }
}
