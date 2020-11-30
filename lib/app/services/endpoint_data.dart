import 'package:flutter/foundation.dart';

class EndPointData {
  final int value;
  final DateTime date;

  EndPointData({@required this.value, this.date});

  @override
  String toString() => 'date: $date, value: $value';
}
