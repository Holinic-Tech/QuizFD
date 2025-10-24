// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:js' as js;

Future<void> webhookCallcvg() async {
  try {
    // Get the app state values
    final quizProfile = FFAppState().quizProfile;
    final contactDetails = FFAppState().submittedContactDetails;

    // Check for null state - return early if null
    if (quizProfile == null) {
      return;
    }

    if (contactDetails == null) {
      return;
    }

    // Parse name into first and last name
    final String fullName = contactDetails.name ?? '';
    String firstName = fullName;
    String lastName = '';

    if (fullName.isNotEmpty) {
      final List<String> nameParts = fullName.trim().split(' ');
      if (nameParts.length > 1) {
        firstName = nameParts[0];
        lastName = nameParts.sublist(1).join(' ');
      }
    }

    // Convert quiz answers to serializable format
    final List<Map<String, dynamic>> answersData = quizProfile.qaPairs
        .map((qaPair) => {
              'questionId': qaPair.questionId,
              'answerIds': qaPair.answerIds,
            })
        .toList();

    // Check if trackEvent function exists
    if (!js.context.hasProperty('trackEvent')) {
      return;
    }

    // Call the JavaScript tracking function
    try {
      final String userEmail = contactDetails.email ?? '';

      js.context.callMethod('trackEvent', [
        'Completed Quiz',
        js.JsObject.jsify({
          'answers': answersData,
          'name': fullName,
          'firstName': firstName,
          'lastName': lastName,
          'email': userEmail,
        }),
        null,
        js.JsObject.jsify({
          '\$email': userEmail,
        }),
        js.JsObject.jsify(['urn:email:$userEmail']),
      ]);
    } catch (jsError) {
      // Silently fail - trackEvent call failed
    }
  } catch (e) {
    // Silently fail - main function error
  }
}
