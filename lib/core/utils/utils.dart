import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static bool isEmptyList(Iterable<dynamic>? list) {
    if (list == null) {
      return true;
    } else if (list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmpty(text) {
    if (text == '' || text == null || text == 'null') {
      return true;
    } else {
      return false;
    }
  }

  static void printWrapped(String? text) {
    RegExp('.{1,800}')
        .allMatches(text ?? '')
        .forEach((match) => debugPrint(match.group(0)));
  }
}
