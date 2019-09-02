// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:im_back/basic/states.dart';
import 'package:im_back/services/box_service.dart';
import 'package:mockito/mockito.dart';


class BoxMockApi extends Mock implements BoxBaseApi {}

void main() {
  group('BoxPool', () {
    test('BoxPool Add', () async {
      var api = BoxMockApi();
      var pool = BoxPoolModel(api: api);

      when(api.generateColor()).thenAnswer((_) async => Future.value(Colors.blue));
      await pool.add();
      expect(pool.items.last.color, Colors.blue);
    });
  });
}
