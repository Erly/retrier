// Copyright (c) 2016, Erlantz Oniga. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library retrier.test;

import 'dart:async';

import 'package:retrier/retrier.dart';
import 'package:test/test.dart';

void main() {
  group('Function works', () {
    Retrier retrier;

    test('Function returns an int', () async {
      const expectedValue = 1;
      retrier = new Retrier<int>(() {
        return expectedValue;
      }, const Duration(milliseconds: 200));
      expect(await retrier.useDelegateMethod(3), expectedValue);
    });

    test('Function returns a string', () async {
      const expectedValue = "Hello Retrier!";
      retrier = new Retrier<String>(() {
        return expectedValue;
      }, const Duration(milliseconds: 200));
      expect(await retrier.useDelegateMethod(3), expectedValue);
    });

    test('Function returns a Future', () async {
      retrier = new Retrier(() {
        return new Future(() => 1);
      }, const Duration(milliseconds: 200));
      expect(await retrier.useDelegateMethod(3), 1);
    });
  });
}
