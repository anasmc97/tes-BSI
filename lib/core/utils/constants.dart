import 'package:flutter/material.dart';

class ScreenUtilSize {
  const ScreenUtilSize._();
  static const double width = 390;
  static const double height = 844;
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum MessageType {
  info,
  warning,
  success,
  danger,
}

class ConstantValue {
  const ConstantValue._();
  static const url = 'https://jsonplaceholder.typicode.com';
}
