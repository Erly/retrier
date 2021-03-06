// Copyright (c) 2016, Erlantz Oniga. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library retrier.test;

import 'dart:async';

import 'package:retrier/retrier.dart';
import 'package:retrier/src/aggregate_exception.dart';
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


  group('Function return exception', () {
    Retrier retrier;

    test('Function fails once', () async {
      const expectedValue = 1;
      var cont = 0;
      retrier = new Retrier<int>(() {
        if (cont == expectedValue) return expectedValue;
        cont++;
        throw new Exception();
      }, const Duration(milliseconds: 200));
      expect(await retrier.useDelegateMethod(3), expectedValue);
    });

    test('Function fails always', () async {
      retrier = new Retrier(() {
        throw new Exception();
      }, const Duration(milliseconds: 200));
      try {
        await retrier.useDelegateMethod(3);
      } catch (ex) {
        expect(ex is AggregateException, true);
        expect(ex.errors.length, 3);
      }
    });
  });
}
