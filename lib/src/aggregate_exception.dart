/// An error that wraps a collection of other [Exception]s.
///
/// It implicitly flattens any [AggregateException]s that occur in the list of
/// exceptions it wraps. Heavily based on Barback library AggregateException
class AggregateException implements Exception {
  final Set<Exception> errors;

  AggregateException(Iterable<Exception> errors)
      : errors = flattenAggregateExceptions(errors).toSet();

  String toString() {
    var buffer = new StringBuffer();
    buffer.writeln("Multiple errors occurred:\n");

    for (var error in errors) {
      buffer.writeln(prefixLines(error.toString(),
          prefix: "  ", firstPrefix: "- "));
    }

    return buffer.toString();
  }
}

Iterable<Exception> flattenAggregateExceptions(
    Iterable<Exception> errors) {
  return errors.expand((error) {
    if (error is! AggregateException) return [error];
    return error.errors;
  });
}

/// Prepends each line in [text] with [prefix]. If [firstPrefix] is passed, the
/// first line is prefixed with that instead.
String prefixLines(String text, {String prefix: '| ', String firstPrefix}) {
  var lines = text.split('\n');
  if (firstPrefix == null) {
    return lines.map((line) => '$prefix$line').join('\n');
  }

  var firstLine = "$firstPrefix${lines.first}";
  lines = lines.skip(1).map((line) => '$prefix$line').toList();
  lines.insert(0, firstLine);
  return lines.join('\n');
}