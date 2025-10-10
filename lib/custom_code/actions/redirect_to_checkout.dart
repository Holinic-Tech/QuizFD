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

import 'dart:js_interop';

@JS('eval')
external JSAny jsEval(String code);

@JS('window.location.href')
external set windowLocationHref(String href);

@JS('window.sessionId') // ✨ ADDED
external JSString? get sessionId; // ✨ ADDED

Future<void> redirectToCheckout() async {
  try {
    String baseUrl =
        "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37/";

    final contactDetails = FFAppState().submittedContactDetails;
    String? email = contactDetails.email;

    String? firstName;
    String? lastName;
    if (contactDetails.name.isNotEmpty) {
      final nameParts = contactDetails.name.split(' ');
      firstName = nameParts.isNotEmpty ? nameParts.first : null;
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
    }

    List<String> queryParams = <String>[];

    // Add contact details parameters
    if (email.isNotEmpty) {
      String emailParam = 'billing_email=${Uri.encodeComponent(email)}';
      queryParams.add(emailParam);
    }

    if (firstName != null && firstName.isNotEmpty) {
      String firstNameParam =
          'billing_first_name=${Uri.encodeComponent(firstName)}';
      queryParams.add(firstNameParam);
    }

    if (lastName != null && lastName.isNotEmpty) {
      String lastNameParam =
          'billing_last_name=${Uri.encodeComponent(lastName)}';
      queryParams.add(lastNameParam);
    }

    // === SIMPLIFIED COUPON LOGIC === (unchanged)
    try {
      final quizProfile = FFAppState().quizProfile;
      String couponTag = '';

      bool hasAnswer(String questionId, List<String> checkAnswers) {
        var questionPair = quizProfile.qaPairs
            .where((pair) => pair.questionId == questionId)
            .toList();
        if (questionPair.isNotEmpty) {
          var answers = questionPair.first.answerIds;
          return checkAnswers.any((answer) => answers.contains(answer));
        }
        return false;
      }

      if (hasAnswer('hairConcern', ['concern_hairloss'])) {
        couponTag = 'c_hl';
        print('Debug - Hair loss concern found, using c_hl');
      } else if (hasAnswer('hairConcern', ['concern_damage']) ||
          hasAnswer('hairConcern', ['concern_splitends'])) {
        couponTag = 'c_dh';
        print('Debug - Damage/split ends concern found, using c_dh');
      } else if (hasAnswer('hairConcern', ['concern_scalp'])) {
        couponTag = 'c_si';
        print('Debug - Scalp concern found, using c_si');
      } else if (hasAnswer('diet', ['diet_custom', 'diet_balanced'])) {
        couponTag = 'd_bc';
        print('Debug - Diet condition found (no hair concerns), using d_bc');
      } else {
        couponTag = 'o_df';
        print('Debug - No conditions met, using default o_df');
      }

      if (couponTag.isNotEmpty) {
        String aeroCouponsParam = 'aero-coupons=${couponTag}';
        queryParams.add(aeroCouponsParam);
        print('Debug - Final coupon: $couponTag');
      }
    } catch (quizError) {
      print('Error processing quiz parameters: $quizError');
      String defaultParam = 'aero-coupons=o_df';
      queryParams.add(defaultParam);
    }
    // === END SIMPLIFIED COUPON LOGIC ===

    // Get CVG cookie value (unchanged)
    String cvgUid = '';
    try {
      final cookieResult = jsEval('''
        (function() {
          const name = "__cvg_uid=";
          const decodedCookie = decodeURIComponent(document.cookie);
          const cookieArray = decodedCookie.split(';');
          
          for (let i = 0; i < cookieArray.length; i++) {
            let cookie = cookieArray[i].trim();
            if (cookie.indexOf(name) === 0) {
              return cookie.substring(name.length, cookie.length);
            }
          }
          return "";
        })()
      ''');

      cvgUid = (cookieResult as JSString).toDart;
      print('Retrieved CVG cookie: $cvgUid');
    } catch (cookieError) {
      print('Error getting cookie: $cookieError');
    }

    if (cvgUid.isNotEmpty) {
      String cvgParam = '__cvg_uid=${Uri.encodeComponent(cvgUid)}';
      queryParams.add(cvgParam);
    }

    // ✨ NEW: Get session ID from JavaScript
    String sessionIdValue = '';
    try {
      final jsSessionId = sessionId;
      if (jsSessionId != null) {
        sessionIdValue = jsSessionId.toDart;
      }
      print('✅ Retrieved session ID: $sessionIdValue');
    } catch (e) {
      print('❌ Error getting session ID: $e');
    }

    // ✨ NEW: Add the session ID if it exists
    if (sessionIdValue.isNotEmpty) {
      String sessionParam = 'session_id=${Uri.encodeComponent(sessionIdValue)}';
      queryParams.add(sessionParam);
      print('✅ Added session_id to params');
    }

    // Construct final URL with all parameters
    if (queryParams.isNotEmpty) {
      baseUrl = baseUrl + '?' + queryParams.join('&');
    }

    print('Redirecting to checkout: $baseUrl');

    // Redirect to the checkout URL
    windowLocationHref = baseUrl;
  } catch (e) {
    print('Error redirecting to checkout: $e');

    windowLocationHref =
        "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37/";
  }
}
