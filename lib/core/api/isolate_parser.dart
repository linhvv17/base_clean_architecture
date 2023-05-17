
import 'dart:isolate';

import 'package:base_clean_architecture/core/core.dart';
class IsolateParser<T> {
  final Map<String, dynamic> json;

  ResponseConverter<T> responseConverter;

  IsolateParser({required this.json, required this.responseConverter});

  Future<T> parseInBackground() async {
    final port = ReceivePort();
    await Isolate.spawn(_parseListOfJson, port.sendPort);

    final result = await port.first;
    return result as T;
  }

  Future<void> _parseListOfJson(SendPort sendPort) async {
    final result = responseConverter(json);
    Isolate.exit(sendPort, result);
  }
}