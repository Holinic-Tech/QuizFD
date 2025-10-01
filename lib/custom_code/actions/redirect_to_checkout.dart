// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:js_interop';

@JS('eval')
external JSAny jsEval(String code);

@JS('window.location.href')
external set windowLocationHref(String href);

Future<void> redirectToCheckout() async {
  try {
    // Base URL for checkout (single URL for all cases)
    String baseUrl =
        "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37/";

    // Get values from app state
    final contactDetails = FFAppState().submittedContactDetails;
    String? email = contactDetails.email;

    String? firstName;
    String? lastName;
    if (contactDetails.name.isNotEmpty) {
      final nameParts = contactDetails.name.split(' ');
      firstName = nameParts.isNotEmpty ? nameParts.first : null;
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
    }

    // Build URL parameters - explicitly typed as List<String>
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

    // === SIMPLIFIED COUPON LOGIC ===
    try {
      final quizProfile = FFAppState().quizProfile;
      String couponTag = '';

      // Helper function to check if a question contains specific answer(s)
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

      // Check hair concerns in priority order

      // 1. Check for hair loss
      if (hasAnswer('hairConcern', ['concern_hairloss'])) {
        couponTag = 'c_hl';
        print('Debug - Hair loss concern found, using c_hl');
      }
      // 2. Check for damaged hair or split ends
      else if (hasAnswer('hairConcern', ['concern_damage']) ||
          hasAnswer('hairConcern', ['concern_splitends'])) {
        couponTag = 'c_dh';
        print('Debug - Damage/split ends concern found, using c_dh');
      }
      // 3. Check for scalp issues
      else if (hasAnswer('hairConcern', ['concern_scalp'])) {
        couponTag = 'c_si';
        print('Debug - Scalp concern found, using c_si');
      }
      // 4. Check for diet condition (only if no hair concerns above)
      else if (hasAnswer('diet', ['diet_custom', 'diet_balanced'])) {
        couponTag = 'd_bc';
        print('Debug - Diet condition found (no hair concerns), using d_bc');
      }
      // 5. Default fallback
      else {
        couponTag = 'o_df';
        print('Debug - No conditions met, using default o_df');
      }

      // Add the single coupon tag as parameter
      if (couponTag.isNotEmpty) {
        String aeroCouponsParam = 'aero-coupons=${couponTag}';
        queryParams.add(aeroCouponsParam);
        print('Debug - Final coupon: $couponTag');
      }
    } catch (quizError) {
      print('Error processing quiz parameters: $quizError');
      // On error, add default o_df tag
      String defaultParam = 'aero-coupons=o_df';
      queryParams.add(defaultParam);
    }
    // === END SIMPLIFIED COUPON LOGIC ===

    // Get CVG cookie value
    String cvgUid = '';
    try {
      // Get cookie value using JavaScript
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
      // Continue without the cookie if there's an error
    }

    // Add the CVG UID if it exists
    if (cvgUid.isNotEmpty) {
      String cvgParam = '__cvg_uid=${Uri.encodeComponent(cvgUid)}';
      queryParams.add(cvgParam);
    }

    // Construct final URL with all parameters
    if (queryParams.isNotEmpty) {
      baseUrl = baseUrl + '?' + queryParams.join('&');
    }

    // Log for debugging
    print('Redirecting to checkout: $baseUrl');

    // Redirect to the checkout URL
    windowLocationHref = baseUrl;
  } catch (e) {
    print('Error redirecting to checkout: $e');

    // Fallback to base URL without any coupons in case of errors
    windowLocationHref =
        "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37/";
  }
}
