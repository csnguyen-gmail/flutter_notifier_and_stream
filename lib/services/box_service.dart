import 'dart:math';

import 'package:flutter/material.dart';

abstract class BoxBaseApi {
  Future<Color> generateColor();
}

class BoxApi implements BoxBaseApi{
  @override
  Future<Color> generateColor() async {
    await Future.delayed(Duration(seconds: 1));
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }
}
