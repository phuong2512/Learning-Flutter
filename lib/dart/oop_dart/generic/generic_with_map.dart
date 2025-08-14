class Cache<K extends Object, V> {
  final Map<K, V> _storage = {};

  // Thêm một mục vào cache
  void put(K key, V value) {
    _storage[key] = value;
  }

  // Lấy giá trị từ cache
  V? get(K key) {
    return _storage[key];
  }

  // Xóa mục khỏi cache
  void remove(K key) {
    _storage.remove(key);
  }

  // Getter để lấy toàn bộ Map
  Map<K, V> get allData => Map.unmodifiable(_storage);
}

void main() {
  // Cache với key là String, value là int
  var numberCache = Cache<String, int>();
  numberCache.put("Alice", 30);
  numberCache.put("Bob", 25);

  print(numberCache.get("Alice")); // In: 30
  print(numberCache.allData); // In: {Alice: 30, Bob: 25}

  numberCache.remove("Bob");
  print(numberCache.allData); // In: {Alice: 30}

  // Cache với key là int, value là String
  var productCache = Cache<int, String>();
  productCache.put(1, "Laptop");
  productCache.put(2, "Phone");

  print(productCache.get(1)); // In: Laptop
  print(productCache.allData); // In: {1: Laptop, 2: Phone}
}