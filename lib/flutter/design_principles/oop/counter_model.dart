class Counter {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
  }

  void reset() {
    _value = 0;
  }
}
