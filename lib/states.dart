import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_back/services.dart';

class BoxPoolModel with ChangeNotifier{
  final List<BoxModel> _items = [];

  BoxPoolModel();

  UnmodifiableListView<BoxModel> get items => UnmodifiableListView(_items);

  void removeLast() {
    if (_items.length == 0) return;
    _items.removeLast();
    // rebuild pool
    notifyListeners();
  }

  void add() {
    // add blank model
    var box = BoxModel();
    _items.add(box);
    // rebuild pool
    notifyListeners();
    // update box
    updateBox(box);
  }

  void updateBox(BoxModel box) async{
    box.color = null;
    try {
      // async api
      box.color = await Api().generateColor();
    } catch (err) {
      print(err);
      _items.remove(box);
      // rebuild pool
      notifyListeners();
    }
  }
}

class BoxModel with ChangeNotifier{
  Color _color;

  Color get color => _color;
  set color(Color value) {
    if (value == _color) return;
    _color = value;
    // rebuild box
    notifyListeners();
  }
}

class ErrorModel with ChangeNotifier{
  String _error;

  String get error => _error;
  set color(String value) {
    _error = value;
    // rebuild box
    notifyListeners();
  }
}
