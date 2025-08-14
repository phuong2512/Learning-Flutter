abstract class Storage<T> {
  void store(T item);
  T retrieve();
}

class MemoryStorage<T> implements Storage<T> {
  T? _item;

  @override
  void store(T item) {
    _item = item;
  }

  @override
  T retrieve() {
    if (_item == null) throw Exception("No item stored");
    return _item!;
  }
}

void main() {
  var intStorage = MemoryStorage<int>();
  intStorage.store(42);
  print(intStorage.retrieve()); // In: 42

  var stringStorage = MemoryStorage<String>();
  stringStorage.store("Hello");
  print(stringStorage.retrieve()); // In: Hello
}