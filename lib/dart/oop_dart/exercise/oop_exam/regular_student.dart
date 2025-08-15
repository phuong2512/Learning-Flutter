import 'package:learning_flutter/dart/oop_dart/exercise/oop_exam/student.dart';

class RegularStudent extends Student {
  final bool b;

  RegularStudent(
    super.studentId,
    super.name,
    super.age,
    super.studentClass,
    super.creditAccumulation,
    this.b,
  );

  @override
  void doSomething() {
    super.getInfo();
    print(
      "Sinh viên hiện đang theo học lớp ${super.studentClass} hệ chính quy",
    );
  }

  void verify(dynamic checkVal) {
    if (checkVal is String) {
      switch (checkVal) {
        case ("A"):
          print("Sinh viên đang theo học ngành CNTT");
        case ("B"):
          print("Sinh viên đang theo học ngành Địa chất");
        case ("C"):
          print("Sinh viên đang theo học ngành Điện");
        case ("D"):
          print("Sinh viên đang theo học ngành Kinh tế");
      }
    } else if (checkVal is int) {
      if (checkVal < 30) {
        print("Sinh viên hiện đang là sinh viên năm 1");
      } else if (checkVal < 60) {
        print("Sinh viên hiện đang là sinh viên năm 2");
      } else if (checkVal < 90) {
        print("Sinh viên hiện đang là sinh viên năm 3");
      } else if (checkVal < 120) {
        print("Sinh viên hiện đang là sinh viên năm 4");
      } else {
        print("Sinh viên hiện đang là sinh viên năm 5");
      }
    }
  }
}
