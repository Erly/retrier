// Copyright (c) 2016, Erlantz Oniga. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library retrier_base;

import 'dart:async';

class Retrier<TResponse> {
  Function _action;
  Duration _retryInterval;

  Retrier(TResponse action(), this._retryInterval) {
    _action = action;
  }

  Future<TResponse> useDelegateMethod([int numberOfAttempts = 1]) =>
      _retryLogic(numberOfAttempts);

  useDelegateMethodNoReturn([int numberOfAttempts = 1]) async {
    await _retryLogic(numberOfAttempts);
  }

  Future<TResponse> _retryLogic([int numberOfAttempts = 1, List<Exception> exList]) async {
    if (exList == null) exList = new List<Exception>(numberOfAttempts);
    try {
      return new Future(() => _action());
    } catch (e) {
      numberOfAttempts--;
      exList.add(e);
      if (numberOfAttempts <= 0) throw exList;
      Future<TResponse> future = new Future.delayed(
          _retryInterval, () => _retryLogic(numberOfAttempts, exList));
      return await future;
    }
  }
}
