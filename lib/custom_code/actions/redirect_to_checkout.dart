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
    // Track which concern type for URL selection
    String concernType = ''; // Will be 'hl', 'dh', 'si', or empty

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

    // === NEW SECTION: Process quiz-based conditional parameters ===
    try {
      final quizProfile = FFAppState().quizProfile;
      List<String> aeroCoupons = <String>[];

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

      // Check hair concern first (for mutual exclusion)
      bool hasHairLoss = hasAnswer('hairConcern', ['concern_hairloss']);
      bool hasScalpConcern = hasAnswer('hairConcern', ['concern_scalp']);
      bool hasHairDamage = hasAnswer('hairConcern', ['concern_damage']);

      print(
          'Debug - Hair Loss: $hasHairLoss, Scalp Concern: $hasScalpConcern, Hair Damage: $hasHairDamage');

      if (hasHairLoss) {
        // Hair Loss Path - Category A
        concernType = 'hl'; // Set concern type for URL
        aeroCoupons.add('c_hl'); // Mandatory tag

        // Create list of potential additional tags with priorities (WITHOUT o_df initially)
        List<Map<String, dynamic>> potentialTags = [];

        // A1. Origin Problem (Priority 1)
        if (hasAnswer('originProblem', [
          'originProblem_schedule',
          'originProblem_majorstress',
          'originProblem_hormones',
          'originProblem_chronic-stress',
          'originProblem_sleep'
        ])) {
          potentialTags.add({'tag': 'op_s', 'priority': 1});
          print('Debug - Origin Problem condition met');
        }

        // A2. Concern Duration (Priority 2)
        if (hasAnswer('concernDuration', ['concernDuration_2+years'])) {
          potentialTags.add({'tag': 'd_2y', 'priority': 2});
          print('Debug - Concern Duration condition met');
        }

        // A3. Current Routine (Priority 3)
        if (hasAnswer(
            'currentRoutine', ['routine_intermediate', 'routine_complex'])) {
          potentialTags.add({'tag': 'r_ci', 'priority': 3});
          print('Debug - Current Routine condition met');
        }

        // A4. Diet (Priority 4)
        if (hasAnswer('diet', ['diet_custom', 'diet_balanced'])) {
          potentialTags.add({'tag': 'd_bc', 'priority': 4});
          print('Debug - Diet condition met');
        }

        print('Debug - Found ${potentialTags.length} condition-based tags');

        // Sort by priority
        potentialTags.sort((a, b) => a['priority'].compareTo(b['priority']));

        // Add ONLY ONE condition-based tag (the highest priority one)
        if (potentialTags.isNotEmpty) {
          String tag = potentialTags[0]['tag'] as String;
          aeroCoupons.add(tag);
          print('Debug - Added condition tag: $tag');
        }

        // If we have less than 2 tags total (c_hl + 1), add o_df
        if (aeroCoupons.length < 2) {
          aeroCoupons.add('o_df');
          print(
              'Debug - Added o_df to fill slot (total tags: ${aeroCoupons.length})');
        }

        print('Debug - Final hair loss tags: ${aeroCoupons.join(',')}');
      } else if (hasHairDamage) {
        // Hair Damage Path - NEW
        concernType = 'dh'; // Set concern type for URL
        aeroCoupons.add('c_dh'); // Mandatory tag

        // Check hairDamageActivity for specific damage types
        List<Map<String, dynamic>> damageTags = [];

        // Check each damage activity type
        if (hasAnswer('hairDamageActivity', ['damageAction_swimming'])) {
          damageTags.add({'tag': 'dp_s', 'priority': 1});
          print('Debug - Swimming damage condition met');
        }

        // Both dye and heat use dp_dht tag but need to check separately
        if (hasAnswer('hairDamageActivity', ['damageAction_dye'])) {
          damageTags.add({'tag': 'dp_dht', 'priority': 2});
          print('Debug - Dye damage condition met');
        }

        if (hasAnswer('hairDamageActivity', ['damageAction_heat'])) {
          // Also uses dp_dht, but we check if it's already added
          bool alreadyHasDht = damageTags.any((tag) => tag['tag'] == 'dp_dht');
          if (!alreadyHasDht) {
            damageTags.add({'tag': 'dp_dht', 'priority': 3});
          }
          print('Debug - Heat damage condition met');
        }

        if (hasAnswer('hairDamageActivity', ['damageAction_sun'])) {
          damageTags.add({'tag': 'dp_uv', 'priority': 4});
          print('Debug - Sun damage condition met');
        }

        if (hasAnswer('hairDamageActivity', ['damageAction_hairstyles'])) {
          damageTags.add({'tag': 'dp_hs', 'priority': 5});
          print('Debug - Hairstyles damage condition met');
        }

        print('Debug - Found ${damageTags.length} damage-based tags');

        // Sort by priority and add only the highest priority one
        if (damageTags.isNotEmpty) {
          damageTags.sort((a, b) => a['priority'].compareTo(b['priority']));
          String tag = damageTags[0]['tag'] as String;
          aeroCoupons.add(tag);
          print('Debug - Added damage tag: $tag');
        } else {
          // No specific damage activities found, add o_df as default
          aeroCoupons.add('o_df');
          print('Debug - No damage activities found, added o_df as default');
        }

        print('Debug - Final hair damage tags: ${aeroCoupons.join(',')}');
      } else if (hasScalpConcern) {
        // Scalp Concern Path - Category B (mutually exclusive with hair loss)
        concernType = 'si'; // Set concern type for URL
        // ONLY c_si, no other tags
        aeroCoupons.add('c_si');
        print('Debug - Scalp concern tag: c_si (only)');
      } else {
        // No hair or scalp concerns - just add default o_df
        aeroCoupons.add('o_df');
        print('Debug - No concerns found, adding default o_df tag');
      }

      // Add aero-coupons parameter if we have any tags
      if (aeroCoupons.isNotEmpty) {
        String aeroCouponsParam = 'aero-coupons=${aeroCoupons.join(',')}';
        queryParams.add(aeroCouponsParam);
        print('Debug - Aero coupons parameter: $aeroCouponsParam');
      }
    } catch (quizError) {
      print('Error processing quiz parameters: $quizError');
      // On error, add default o_df tag
      String defaultParam = 'aero-coupons=o_df';
      queryParams.add(defaultParam);
    }
    // === END NEW SECTION ===

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

    // Select the appropriate base URL based on concern type
    String baseUrl;
    if (concernType == 'hl') {
      baseUrl =
          "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37-hl/";
    } else if (concernType == 'dh') {
      baseUrl =
          "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37-dh/";
    } else if (concernType == 'si') {
      baseUrl =
          "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37-si/";
    } else {
      baseUrl =
          "https://checkout.hairqare.co/buy/hairqare-challenge-save-85-5-37/";
    }

    // Construct final URL with all parameters
    if (queryParams.isNotEmpty) {
      baseUrl = baseUrl + '?' + queryParams.join('&');
    }

    // Log for debugging
    print('Debug - Concern type: $concernType');
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
