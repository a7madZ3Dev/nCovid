import 'package:flutter/foundation.dart';

class EndpointData {
  final int value;
  final DateTime date;

  EndpointData({
    @required this.value,
    this.date,
  }) : assert(value != null);

  @override
  String toString() {
    return 'date: $date, value: $value';
  }
  
}
