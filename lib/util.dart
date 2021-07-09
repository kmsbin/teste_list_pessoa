import 'dart:math';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Utils {
  static MaskTextInputFormatter maskFormatter = new MaskTextInputFormatter(mask: ' (##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  static var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
