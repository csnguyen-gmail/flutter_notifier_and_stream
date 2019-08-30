import 'dart:collection';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoxPoolModel with ChangeNotifier{
  final List<BoxModel> _items = [];

  UnmodifiableListView<BoxModel> get items => UnmodifiableListView(_items);

  void add() {
    var box = BoxModel();
    box.color = generateColor();
    _items.add(box);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeLast() {
    if (_items.length == 0) return;
    _items.removeLast();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void randomUpdate() {
    var box = _items[Random().nextInt(_items.length)];
    box.color = generateColor();
  }

  // util
  Color generateColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }
}

class BoxModel with ChangeNotifier{
  Color _color;

  Color get color => _color;
  set color(Color value) {
    _color = value;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}
