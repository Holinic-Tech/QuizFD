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

    // Coupon logic
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
      } else if (hasAnswer('hairConcern', ['concern_damage']) ||
          hasAnswer('hairConcern', ['concern_splitends'])) {
        couponTag = 'c_dh';
      } else if (hasAnswer('hairConcern', ['concern_scalp'])) {
        couponTag = 'c_si';
      } else if (hasAnswer('diet', ['diet_custom', 'diet_balanced'])) {
        couponTag = 'd_bc';
      } else {
        couponTag = 'o_df';
      }

      if (couponTag.isNotEmpty) {
        String aeroCouponsParam = 'aero-coupons=${couponTag}';
        queryParams.add(aeroCouponsParam);
      }
    } catch (quizError) {
      String defaultParam = 'aero-coupons=o_df';
      queryParams.add(defaultParam);
    }

    // Get CVG UID - try cookie first, then URL
    String cvgUid = '';
    try {
      final cookieResult = jsEval('''
        (function() {
          // Try cookie first
          const name = "__cvg_uid=";
          const decodedCookie = decodeURIComponent(document.cookie);
          const cookieArray = decodedCookie.split(';');
          
          for (let i = 0; i < cookieArray.length; i++) {
            let cookie = cookieArray[i].trim();
            if (cookie.indexOf(name) === 0) {
              return cookie.substring(name.length, cookie.length);
            }
          }
          
          // Fallback: try URL parameter
          const urlParams = new URLSearchParams(window.location.search);
          return urlParams.get('__cvg_uid') || "";
        })()
      ''');

      cvgUid = (cookieResult as JSString).toDart;
    } catch (cookieError) {
      // Silently fail
    }

    if (cvgUid.isNotEmpty) {
      String cvgParam = '__cvg_uid=${Uri.encodeComponent(cvgUid)}';
      queryParams.add(cvgParam);
    }

    // Get CVG SID - try cookie first, then URL
    String cvgSid = '';
    try {
      final cookieResult = jsEval('''
        (function() {
          // Try cookie first
          const name = "__cvg_sid=";
          const decodedCookie = decodeURIComponent(document.cookie);
          const cookieArray = decodedCookie.split(';');
          
          for (let i = 0; i < cookieArray.length; i++) {
            let cookie = cookieArray[i].trim();
            if (cookie.indexOf(name) === 0) {
              return cookie.substring(name.length, cookie.length);
            }
          }
          
          // Fallback: try URL parameter
          const urlParams = new URLSearchParams(window.location.search);
          return urlParams.get('__cvg_sid') || "";
        })()
      ''');

      cvgSid = (cookieResult as JSString).toDart;
    } catch (cookieError) {
      // Silently fail
    }

    if (cvgSid.isNotEmpty) {
      String cvgSidParam = '__cvg_sid=${Uri.encodeComponent(cvgSid)}';
      queryParams.add(cvgSidParam);
    }

    // Construct final URL with all parameters
    if (queryParams.isNotEmpty) {
      baseUrl = baseUrl + '?' + queryParams.join('&');
    }

    // Redirect to the checkout URL
    windowLocationHref = baseUrl;
  } catch (e) {
    windowLocationHref =
        "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37/";
  }
}
