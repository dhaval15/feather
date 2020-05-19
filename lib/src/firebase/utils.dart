class IndexedMap<Key, Value> {
  final List<Key> _keys = [];
  final List<Value> _values = [];
  Iterable<Key> get keys => _keys;
  Iterable<Value> get values => _values;

  operator [](Key key) => _values[_keys.indexOf(key)];
  operator []=(Key key, Value value) {
    final oldIndex = _keys.indexOf(key);
    if (oldIndex < 0) {
      _values.add(value);
      _keys.add(key);
    } else {
      _values[oldIndex] = value;
    }
  }
}
