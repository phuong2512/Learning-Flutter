import 'package:learning_flutter/dart/oop_dart/exercise/oop_exam/in_service_student.dart';
import 'package:learning_flutter/dart/oop_dart/exercise/oop_exam/regular_student.dart';

void main() {
  var _student1 = RegularStudent(2124159587, "Nam", 19, "A001", 2, false);
  var _student2 = RegularStudent(2123168787, "Giang", 20, "B002", 48, true);
  var _student3 = InServiceStudent(2120487225, "Mạnh", 22, "E010", 114, "");

  _student2.getInfo();

  _student1.doSomething();
  _student1.verify(_student1.studentClass[0]);
  _student1.verify(_student1.creditAccumulation);

  print("----------------------------------------------------\n");
  _student2.doSomething();
  _student2.verify(_student2.studentClass[0]);
  _student2.verify(_student2.creditAccumulation);

  print("----------------------------------------------------\n");
  _student3.doSomething();
}
