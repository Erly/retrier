# retrier

A library for running from 1 to n times a function that can fail due to some external factors, like a http request.

## Usage

A simple usage example:

    import 'package:retrier/retrier.dart';

    main() {
    const numberOfAttempts = 3;
      var retrier = new Retrier<int>(() {
        int n = functionThatCanFail();
        return n;
      }, const Duration(milliseconds: 200));
      
      try {
        var returnedValue = retrier.useDelegateMethod(3);
      } catch (e) {
        print(e);
      }
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
