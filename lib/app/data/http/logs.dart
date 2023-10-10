part of 'http.dart';

void _printLogs(Map<String, dynamic> logs, StackTrace? st) {
  print(logs.toString());
  log('''
🛠️
--------------------------------------------------------
${const JsonEncoder.withIndent(' ').convert(logs)}
--------------------------------------------------------
🛠️
''', stackTrace: st);
}
