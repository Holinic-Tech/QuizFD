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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:js' as js;

Future<void> webhookCallQuizProfile() async {
  final loggingWebhook =
      'https://hook.us1.make.com/12ojmstexumn6knualpsn9hkex9qy8b3';
  final makeWebhook =
      'https://hook.us1.make.com/3d6vksxwtqukhrx465bjymy4y6sfdkr6';

  // ✨ UPDATED: Fire-and-forget logging (never blocks)
  void logEvent(String eventType, Map<String, dynamic> data) {
    try {
      http
          .post(
            Uri.parse(loggingWebhook),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'event': eventType,
              'timestamp': DateTime.now().toIso8601String(),
              'data': data,
              'userAgent': js.context['navigator']['userAgent'].toString(),
              'url': js.context['location']['href'].toString(),
            }),
          )
          .timeout(Duration(seconds: 2))
          .catchError((e) {
        print('[LOG ERROR] $e');
      });
    } catch (e) {
      print('[LOG ERROR] $e');
    }
  }

  try {
    logEvent('webhook_quiz_profile_start', {}); // ✨ No await!

    final quizProfile = FFAppState().quizProfile;
    final cdpMapping = FFAppState().cdpMapping;
    final contactDetails = FFAppState().submittedContactDetails;

    if (quizProfile == null || contactDetails == null) {
      logEvent('webhook_quiz_profile_null_state', {
        'quizProfile_null': quizProfile == null,
        'contactDetails_null': contactDetails == null,
      });
      print('[ERROR] Missing state');
      return;
    }

    logEvent('webhook_quiz_profile_state_ok', {
      'qaPairs_count': quizProfile.qaPairs?.length ?? 0,
      'has_email': contactDetails.email?.isNotEmpty ?? false,
    });

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

    var jsonPayload = jsonEncode(payload);
    print('[WEBHOOK] Sending to Make.com');

    logEvent('webhook_quiz_profile_sending', {
      'payload_size': jsonPayload.length,
      'email': contactDetails.email ?? '',
    });

    // Fire and forget - don't wait for response
    http
        .post(
          Uri.parse(makeWebhook),
          headers: {'Content-Type': 'application/json'},
          body: jsonPayload,
        )
        .timeout(Duration(seconds: 10))
        .then((response) {
      print('[WEBHOOK] Response: ${response.statusCode}');

      logEvent('webhook_quiz_profile_response', {
        'status_code': response.statusCode,
        'success': response.statusCode == 200,
      });

      // Retry if failed
      if (response.statusCode != 200) {
        print('[WEBHOOK] Retrying...');
        logEvent('webhook_quiz_profile_retry', {});

        http
            .post(
              Uri.parse(makeWebhook),
              headers: {'Content-Type': 'application/json'},
              body: jsonPayload,
            )
            .timeout(Duration(seconds: 10))
            .then((retryResponse) {
          print('[WEBHOOK] Retry response: ${retryResponse.statusCode}');
          logEvent('webhook_quiz_profile_retry_response', {
            'status_code': retryResponse.statusCode,
          });
        }).catchError((retryError) {
          print('[ERROR] Retry failed: $retryError');
        });
      }
    }).catchError((error) {
      print('[ERROR] HTTP call failed: $error');
      logEvent('webhook_quiz_profile_http_error', {
        'error': error.toString(),
      });
    });

    print('[WEBHOOK] Sent in background - continuing...');
    logEvent('webhook_quiz_profile_complete', {});
  } catch (e, stackTrace) {
    logEvent('webhook_quiz_profile_error', {
      'error': e.toString(),
      'stack': stackTrace.toString().substring(0, 500),
    });
    print('[ERROR] $e');
  }
}
