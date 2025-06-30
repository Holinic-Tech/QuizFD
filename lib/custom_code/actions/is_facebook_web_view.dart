// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:html' as html;

Future<bool> isFacebookWebView() async {
  // Get the user agent string
  final userAgent = html.window.navigator.userAgent.toLowerCase();

  // Check for Facebook WebView identifiers (excluding Instagram)
  // FBAN = Facebook Android
  // FBIOS = Facebook iOS
  // FB_IAB = Facebook In-App Browser (also check this for broader coverage)
  final isFacebookOnly = (userAgent.contains('fban') ||
          userAgent.contains('fbios') ||
          userAgent.contains('fb_iab')) &&
      !userAgent.contains('instagram');

  // Log for debugging
  print('User Agent: $userAgent');
  print('Is Facebook WebView: $isFacebookOnly');

  return isFacebookOnly;
}
