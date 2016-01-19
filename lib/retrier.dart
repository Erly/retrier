// Copyright (c) 2016, Erlantz Oniga. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The retrier library.
///
/// This is a library to call a function from 1 to n times until it works. If it
/// fails n times it will return a [AggregateException] with all the exceptions
/// returned during those calls.
library retrier;

export 'src/retrier_base.dart';
