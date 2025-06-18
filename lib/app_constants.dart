import 'package:flutter/material.dart';

abstract class FFAppConstants {
  static const double horizontalPadding = 20.0;

  /// CONTINUE
  static const String continues = 'CONTINUE';
  static const String back = 'BACK';
  static const double templateTopPadding = 10.0;

  /// App Gradient color List
  static const List<Color> appGradient = [
    Color(4285756838),
    Color(4289837795),
    Color(4294105798)
  ];
  static const List<String> nonQuestionAnswerItem = ['not applicable'];

  /// Dirty workaround to quickly get the dialog window tested which opos up
  /// when someone clicks "yes" on start screen.
  ///
  /// the answer is not passed across screens and needs a better handover but
  /// dont have enough time to do this right now
  static const List<String> yes = ['Yes'];

  /// Dirty workaround to quickly get the dialog window tested which opos up
  /// when someone clicks "yes" on start screen.
  ///
  /// the answer is not passed across screens and needs a better handover but
  /// dont have enough time to do this right now
  static const List<String> diagnosisFDyes = ['diagnosisFD_yes'];
}
