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

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> webhookCallQuizProfile() async {
  final makeWebhook =
      'https://hook.us1.make.com/3d6vksxwtqukhrx465bjymy4y6sfdkr6';

  try {
    final quizProfile = FFAppState().quizProfile;
    final cdpMapping = FFAppState().cdpMapping;
    final contactDetails = FFAppState().submittedContactDetails;

    if (quizProfile == null || contactDetails == null) {
      return;
    }

    var acFields = <String, dynamic>{};
    var mpFields = <String, dynamic>{};

    if (quizProfile.qaPairs != null) {
      for (var qaPair in quizProfile.qaPairs) {
        var mappings = cdpMapping
            .where((mapping) => mapping.questionId == qaPair.questionId)
            .toList();

        if (mappings.isNotEmpty) {
          var mapping = mappings.first;

          if (mapping.acField != null && mapping.acField > 0) {
            String answer = qaPair.answerIds.join(', ');
            acFields['field_${mapping.acField}'] = answer;
          }

          if (mapping.mpField != null && mapping.mpField.isNotEmpty) {
            if (qaPair.answerIds.length > 1) {
              mpFields[mapping.mpField] = qaPair.answerIds;
            } else {
              mpFields[mapping.mpField] =
                  qaPair.answerIds.isNotEmpty ? qaPair.answerIds.first : '';
            }
          }
        }
      }
    }

    String fullName = contactDetails.name ?? '';
    String firstName = fullName;
    String lastName = '';

    if (fullName.isNotEmpty) {
      List<String> nameParts = fullName.trim().split(' ');
      if (nameParts.length > 1) {
        firstName = nameParts[0];
        lastName = nameParts.sublist(1).join(' ');
      }
    }

    mpFields[r'$name'] = fullName;
    mpFields[r'$email'] = contactDetails.email ?? '';

    var payload = {
      'name': fullName,
      'firstName': firstName,
      'lastName': lastName,
      'email': contactDetails.email ?? '',
      'quizData': {
        'rawAnswers': quizProfile.qaPairs
            .map((qaPair) => {
                  'questionId': qaPair.questionId,
                  'answerIds': qaPair.answerIds,
                })
            .toList(),
      },
      'activeCampaign': acFields,
      'mixpanel': mpFields,
    };

    // Fire and forget - no await, no timeout, no response handling
    http.post(
      Uri.parse(makeWebhook),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
  } catch (e) {
    // Silently fail
  }
}
