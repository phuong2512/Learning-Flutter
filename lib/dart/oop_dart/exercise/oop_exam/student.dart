abstract class Student {
  late int _studentId;
  late String _name;
  late int _age;
  late String _class;
  late int _creditAccumulation;

  Student(
    this._studentId,
    this._name,
    this._age,
    this._class,
    this._creditAccumulation,
  );

  void _getInfo() {
    print(
      "Mã sinh viên: $_studentId, Tên: $_name, Tuổi: $_age, Số tín chỉ: $_creditAccumulation",
    );
  }

  int studentId() => _studentId;

  String get name => _name;
  set name(String value) => _name = value;

  int get age => _age;
  set age(int value) => _age = value;

  String get studentClass => _class;
  set studentClass(String value) => _class = value;

  int get creditAccumulation => _creditAccumulation;
  set creditAccumulation(int value) => _creditAccumulation = value;

  void getInfo() => _getInfo();

  void doSomething();
}
