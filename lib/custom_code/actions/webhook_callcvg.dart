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
import 'dart:js' as js;

Future<void> webhookCallcvg() async {
  // REPLACE WITH YOUR MAKE.COM LOGGING WEBHOOK
  final loggingWebhook =
      'https://hook.us1.make.com/12ojmstexumn6knualpsn9hkex9qy8b3';

  // Helper function to log events
  Future<void> logEvent(String eventType, Map<String, dynamic> data) async {
    try {
      final payload = {
        'event': eventType,
        'timestamp': DateTime.now().toIso8601String(),
        'data': data,
        'userAgent': js.context['navigator']['userAgent'].toString(),
        'url': js.context['location']['href'].toString(),
      };

      print('[LOG] $eventType: $data');

      await http
          .post(
            Uri.parse(loggingWebhook),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(Duration(seconds: 3));
    } catch (e) {
      print('[LOG ERROR] Failed to log $eventType: $e');
    }
  }

  try {
    await logEvent('webhook_start', {
      'action': 'webhookCallcvg',
      'timestamp_start': DateTime.now().toIso8601String(),
    });

    // Get the app state values - declare as nullable
    final quizProfile = FFAppState().quizProfile;
    final contactDetails = FFAppState().submittedContactDetails;

    // Log state retrieval
    await logEvent('state_retrieved', {
      'has_quizProfile': quizProfile != null,
      'has_contactDetails': contactDetails != null,
      'qaPairs_count': quizProfile?.qaPairs?.length ?? 0,
      'has_name': (contactDetails?.name?.isNotEmpty ?? false),
      'has_email': (contactDetails?.email?.isNotEmpty ?? false),
    });

    // Check for null state - return early if null
    if (quizProfile == null) {
      await logEvent('webhook_error_null_state', {
        'error': 'quizProfile is null',
        'contactDetails_exists': contactDetails != null,
      });
      print('[ERROR] quizProfile is null!');
      return;
    }

    if (contactDetails == null) {
      await logEvent('webhook_error_null_state', {
        'error': 'contactDetails is null',
        'quizProfile_exists': true,
      });
      print('[ERROR] contactDetails is null!');
      return;
    }

    // At this point, we know contactDetails is NOT null
    // So we can safely access its properties
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

    // SET SENTRY USER CONTEXT
    try {
      if (js.context.hasProperty('setSentryUser')) {
        js.context.callMethod('setSentryUser', [
          contactDetails.email ?? '',
          fullName,
        ]);
        print('[SENTRY] User context set: ${contactDetails.email ?? ""}');

        await logEvent('sentry_user_set', {
          'email': contactDetails.email ?? '',
          'name': fullName,
        });
      } else {
        print('[SENTRY] setSentryUser function not found');
        await logEvent('sentry_user_not_set', {
          'reason': 'setSentryUser function not found',
        });
      }
    } catch (sentryError) {
      print('[SENTRY] Failed to set user context: $sentryError');
      await logEvent('sentry_user_error', {
        'error': sentryError.toString(),
      });
    }

    // Convert quiz answers to serializable format
    final List<Map<String, dynamic>> answersData = quizProfile.qaPairs
        .map((qaPair) => {
              'questionId': qaPair.questionId,
              'answerIds': qaPair.answerIds,
            })
        .toList();

    await logEvent('data_prepared', {
      'fullName': fullName,
      'email': contactDetails.email ?? '',
      'answersCount': answersData.length,
    });

    // Check if trackEvent function exists
    final bool trackEventExists = js.context.hasProperty('trackEvent');
    final bool cvgExists = js.context.hasProperty('cvg');
    final bool cvgLoaded = js.context.hasProperty('cvgLoaded')
        ? (js.context['cvgLoaded'] == true)
        : false;

    await logEvent('before_js_call', {
      'trackEvent_exists': trackEventExists,
      'cvg_exists': cvgExists,
      'window_cvgLoaded': cvgLoaded,
    });

    if (!trackEventExists) {
      await logEvent('trackEvent_not_found', {
        'error': 'trackEvent function does not exist on window',
      });
      print('[ERROR] trackEvent function not found!');

      if (js.context.hasProperty('sentryCaptureError')) {
        js.context.callMethod('sentryCaptureError', [
          'trackEvent function not found',
          js.JsObject.jsify({'cvgLoaded': cvgLoaded}),
        ]);
      }

      return;
    }

    // Call the JavaScript tracking function
    try {
      print('[CVG] Calling trackEvent...');

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

      await logEvent('js_call_success', {
        'message': 'trackEvent called successfully',
        'eventName': 'Completed Quiz',
      });

      if (js.context.hasProperty('sentryCaptureEvent')) {
        js.context.callMethod('sentryCaptureEvent', [
          'Quiz Completed',
          js.JsObject.jsify({
            'email': userEmail,
            'answersCount': answersData.length,
          }),
        ]);
      }

      print('[CVG] trackEvent called successfully');
    } catch (jsError) {
      await logEvent('js_call_error', {
        'error': jsError.toString(),
        'error_type': jsError.runtimeType.toString(),
      });
      print('[ERROR] JavaScript call failed: $jsError');

      if (js.context.hasProperty('sentryCaptureError')) {
        js.context.callMethod('sentryCaptureError', [
          'CVG trackEvent call failed',
          js.JsObject.jsify({
            'error': jsError.toString(),
          }),
        ]);
      }
    }

    await logEvent('webhook_complete', {
      'status': 'success',
    });

    print('[CVG] CVG tracking event completed');
  } catch (e, stackTrace) {
    await logEvent('webhook_error', {
      'error': e.toString(),
      'error_type': e.runtimeType.toString(),
      'stackTrace': stackTrace.toString().substring(0, 500),
    });

    if (js.context.hasProperty('sentryCaptureError')) {
      try {
        js.context.callMethod('sentryCaptureError', [
          'webhookCallcvg failed: ${e.toString()}',
          js.JsObject.jsify({
            'stackTrace': stackTrace.toString().substring(0, 500),
          }),
        ]);
      } catch (sentryError) {
        print('[SENTRY] Failed to capture error: $sentryError');
      }
    }

    print('[ERROR] Exception caught in webhookCallcvg:');
    print('Error message: $e');
    print('Stack trace: $stackTrace');
  }
}
