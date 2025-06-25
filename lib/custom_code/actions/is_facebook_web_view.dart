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

  // Check for Facebook WebView identifiers
  // FBAN = Facebook Android
  // FBAV = Facebook App Version
  // FB_IAB = Facebook In-App Browser
  // FBIOS = Facebook iOS
  // FBLC = Facebook Locale
  // Instagram also uses similar WebView
  final isFacebook = userAgent.contains('fban') ||
      userAgent.contains('fbav') ||
      userAgent.contains('fb_iab') ||
      userAgent.contains('fbios') ||
      userAgent.contains('fblc') ||
      userAgent.contains('instagram');

  // Log for debugging
  print('User Agent: $userAgent');
  print('Is Facebook WebView: $isFacebook');

  return isFacebook;
}
