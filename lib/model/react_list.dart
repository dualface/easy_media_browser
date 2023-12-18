import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReactItem extends ChangeNotifier {
  ReactItem({isSelected = false}) {
    _isSelected = isSelected;
  }

  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  bool _isSelected = false;
}

class ReactList<T extends ReactItem> extends ChangeNotifier {
  ReactList({List<T> items = const []}) {
    _items.clear();
    _items.addAll(items);
  }

  int get length => _items.length;
  int get selectedIndex => _selectedIndex;
  T get selected => _items[_selectedIndex];
  T get(int index) => _items[index];

  final List<T> _items = [];
  int _selectedIndex = -1;

  void append(T item) {
    _items.add(item);
    if (_selectedIndex == -1) {
      _setSelected(0);
    }
    notifyListeners();
  }

  void insert(int index, T item) {
    _items.insert(index, item);
    if (_selectedIndex == -1) {
      _setSelected(0);
    }
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    if (_selectedIndex >= _items.length) {
      _setSelected(_items.length - 1);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void setSelected(int index) {
    _setSelected(index);
    notifyListeners();
  }

  void selectNext() {
    if (_selectedIndex < _items.length - 1) {
      _setSelected(_selectedIndex + 1);
      notifyListeners();
    }
  }

  void _setSelected(int index) {
    for (var element in _items) {
      element.isSelected = false;
    }
    if (index >= 0 && index < _items.length) {
      _items[index].isSelected = true;
    }
    _selectedIndex = index;
  }
}
