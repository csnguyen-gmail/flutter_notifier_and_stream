import 'dart:math';

import 'package:flutter/material.dart';

class Api {
  static final Api _instance = Api._internal();
  int _count = 9;
  factory Api() => _instance;

  Api._internal() {
    // init things inside this
  }

  Future<Color> generateColor() async{
    await Future.delayed(Duration(seconds: 2));
    if (++_count % 3 == 0) { // throw error after 2 OK for testing
      throw("cannot get color");
    }
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }
}