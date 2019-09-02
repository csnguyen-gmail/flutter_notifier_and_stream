import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_back/services/box_service.dart';

class BoxPoolModel with ChangeNotifier{
  final List<BoxModel> _items = [];
  final BoxBaseApi api;

  BoxPoolModel({
    @required this.api,
  });

  UnmodifiableListView<BoxModel> get items => UnmodifiableListView(_items);

  void removeLast() {
    if (_items.length == 0) return;
    _items.removeLast();
    // rebuild pool
    notifyListeners();
  }

  Future add() async{
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
    box.color = await api.generateColor();
  }
}

class BoxModel with ChangeNotifier{
  Color _color;
  Color get color => _color;
  set color(Color value) {
    _color = value;
    // rebuild box
    notifyListeners();
  }
}