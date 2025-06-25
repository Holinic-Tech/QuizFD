import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'de', 'fr'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? deText = '',
    String? frText = '',
  }) =>
      [enText, esText, deText, frText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    'x8ai5u31': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hjp0vvi2': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'd4329zzl': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'g2q0w5rd': {
      'en': 'Which hair type do you have?',
      'de': 'Welchen Haartyp haben Sie?',
      'es': '¿Qué tipo de cabello tienes?',
      'fr': 'Quel type de cheveux avez-vous ?',
    },
    'bdqv46ra': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'uaeia9o3': {
      'en': 'How old are you?',
      'de': 'Wie alt bist du?',
      'es': '¿Cuántos años tiene?',
      'fr': 'Quel âge as-tu?',
    },
    'zf9jz0od': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'i2ojmi0m': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '15jpp8px': {
      'en': 'What is your biggest hair concern right now?',
      'de': 'Was ist im Moment Ihr größtes Haarproblem?',
      'es': '¿Cuál es tu mayor preocupación capilar en este momento?',
      'fr':
          'Quelle est votre plus grande préoccupation capillaire en ce moment ?',
    },
    'onimc71u': {
      'en': ' Select one',
      'de': 'Wählen Sie eine aus',
      'es': 'Seleccione uno',
      'fr': 'Sélectionnez-en un',
    },
    '3qsxpsqp': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zaokmujb': {
      'en': 'What best describes your current haircare routine?',
      'de': 'Was beschreibt Ihre aktuelle Haarpflegeroutine am besten?',
      'es': '¿Qué describe mejor tu rutina actual de cuidado del cabello?',
      'fr':
          'Qu’est-ce qui décrit le mieux votre routine actuelle de soins capillaires ?',
    },
    'dp0mkedt': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'blcnnajw': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'm7uh7oex': {
      'en':
          'How familiar are you with HairQare and our approach to holistic haircare?',
      'de':
          'Wie gut kennen Sie HairQare und unseren Ansatz zur ganzheitlichen Haarpflege?',
      'es':
          '¿Qué tan familiarizado está con HairQare y nuestro enfoque en el cuidado holístico del cabello?',
      'fr':
          'Connaissez-vous HairQare et notre approche des soins capillaires holistiques ?',
    },
    '646rpwwb': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rn48g3to': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'g791wwh4': {
      'en': 'Beautiful hair needs more than just products.',
      'de': 'Schönes Haar braucht mehr als nur Produkte.',
      'es': 'Un cabello hermoso necesita más que sólo productos.',
      'fr': 'De beaux cheveux nécessitent plus que de simples produits.',
    },
    '5begehn5': {
      'en':
          'Our evidence-based programs are developed by Sarah Tran, a certified hair loss specialist, along with a team of researchers, formulation scientists, and medical professionals. ',
      'de':
          'Unsere evidenzbasierten Programme werden von Sarah Tran, einer zertifizierten Haarausfallspezialistin, zusammen mit einem Team aus Forschern, Formulierungswissenschaftlern und medizinischem Fachpersonal entwickelt.',
      'es':
          'Nuestros programas basados en evidencia son desarrollados por Sarah Tran, especialista certificada en pérdida del cabello, junto con un equipo de investigadores, científicos de formulación y profesionales médicos.',
      'fr':
          'Nos programmes fondés sur des preuves sont développés par Sarah Tran, spécialiste certifiée en perte de cheveux, en collaboration avec une équipe de chercheurs, de scientifiques en formulation et de professionnels de la santé.',
    },
    'dnzs3t47': {
      'en':
          'Clinically proven to restore hair follicle balance quickly and permanently.',
      'de': 'Klinisch erwiesen: Heilt Ihr Haar schnell und dauerhaft.',
      'es':
          'Clínicamente probado para curar tu cabello de forma rápida y permanente.',
      'fr':
          'Cliniquement prouvé pour guérir vos cheveux rapidement et durablement.',
    },
    's3viwwxq': {
      'en': 'Proven Results for:',
      'de': 'Nachgewiesene Ergebnisse für:',
      'es': 'Resultados comprobados para:',
      'fr': 'Résultats prouvés pour :',
    },
    'dhw0xi88': {
      'en': 'Any hair concern ',
      'de': 'Jedes Haarproblem',
      'es': '¿Alguna preocupación sobre el cabello?',
      'fr': 'Tout problème de cheveux',
    },
    'vyzhveff': {
      'en': 'Any age',
      'de': 'Jedes Alter',
      'es': 'Cualquier edad',
      'fr': 'Tout âge',
    },
    't05pit2o': {
      'en': 'Any hair type',
      'de': 'Jeder Haartyp',
      'es': 'Cualquier tipo de cabello',
      'fr': 'Tout type de cheveux',
    },
    'kuvd0wnn': {
      'en': 'Any hair goal',
      'de': 'Jedes Haarziel',
      'es': 'Cualquier objetivo capilar',
      'fr': 'N\'importe quel objectif capillaire',
    },
    'khaadglv': {
      'en': 'What best describes your diet?',
      'de': 'Was beschreibt Ihre Ernährung am besten?',
      'es': '¿Qué describe mejor tu dieta?',
      'fr': 'Qu’est-ce qui décrit le mieux votre régime alimentaire ?',
    },
    'x3t83a7y': {
      'en': 'What we eat affects our hair growth and quality.',
      'de':
          'Was wir essen, beeinflusst unser Haarwachstum und unsere Haarqualität.',
      'es':
          'Lo que comemos afecta el crecimiento y la calidad de nuestro cabello.',
      'fr':
          'Ce que nous mangeons affecte la croissance et la qualité de nos cheveux.',
    },
    '25wr54y6': {
      'en': 'How much do you spend on a bottle of shampoo?',
      'de': 'Wie viel geben Sie für eine Flasche Shampoo aus?',
      'es': '¿Cuánto gastas en una botella de champú?',
      'fr': 'Combien dépensez-vous pour une bouteille de shampoing ?',
    },
    'rihaqphi': {
      'en': 'Which of these hair care myths do you believe?',
      'de': 'Welchen dieser Haarpflegemythen glauben Sie?',
      'es': '¿En cuál de estos mitos sobre el cuidado del cabello crees?',
      'fr': 'Auquel de ces mythes sur les soins capillaires croyez-vous ?',
    },
    'ugf9xggr': {
      'en': 'Select the damaging practices that you regularly do',
      'de':
          'Wählen Sie die schädlichen Praktiken aus, die Sie regelmäßig durchführen',
      'es': 'Selecciona las prácticas dañinas que realizas habitualmente',
      'fr': 'Sélectionnez les pratiques néfastes que vous faites régulièrement',
    },
    'o7lj8r75': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xgrtm968': {
      'en':
          'Here is what you can achieve in 14 days of following the right routine for your hair:',
      'de':
          'Folgendes können Sie in 14 Tagen erreichen, wenn Sie die richtige Routine für Ihr Haar befolgen:',
      'es':
          'Esto es lo que puedes lograr en 14 días siguiendo la rutina adecuada para tu cabello:',
      'fr':
          'Voici ce que vous pouvez réaliser en 14 jours en suivant la bonne routine pour vos cheveux :',
    },
    'runyv089': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '67s8av9p': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'wrw01rih': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6atwdsko': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'miv9wl0i': {
      'en': 'According to your answers, your dysfunction type is:',
      'de': '',
      'es': '',
      'fr': '',
    },
    'o3yak32t': {
      'en': 'Have you experienced any of the following in the last 6 months? ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'vazebtnl': {
      'en': 'My reflection in the mirror affects my mood and self-esteem.',
      'de':
          'Mein Spiegelbild beeinflusst meine Stimmung und mein Selbstwertgefühl.',
      'es':
          'Mi reflejo en el espejo afecta mi estado de ánimo y mi autoestima.',
      'fr':
          'Mon reflet dans le miroir affecte mon humeur et mon estime de moi.',
    },
    'ltw8dxc6': {
      'en': 'How much do you relate to the following statement?',
      'de':
          'Inwieweit können Sie sich mit der folgenden Aussage identifizieren?',
      'es': '¿En qué medida te identificas con la siguiente afirmación?',
      'fr':
          'Dans quelle mesure vous identifiez-vous à l’affirmation suivante ?',
    },
    'zcjftwlh': {
      'en': 'I tend to compare my hair to others\' and it makes me frustrated.',
      'de':
          'Ich neige dazu, meine Haare mit denen anderer zu vergleichen und das frustriert mich.',
      'es':
          'Tengo tendencia a comparar mi cabello con el de los demás y eso me frustra.',
      'fr':
          'J\'ai tendance à comparer mes cheveux à ceux des autres et cela me frustre.',
    },
    'j1jzv4xz': {
      'en': 'How much do you relate to the following statement?',
      'de':
          'Inwieweit können Sie sich mit der folgenden Aussage identifizieren?',
      'es': '¿En qué medida te identificas con la siguiente afirmación?',
      'fr':
          'Dans quelle mesure vous identifiez-vous à l’affirmation suivante ?',
    },
    'hoc1sdcs': {
      'en': 'Did a professional refer you to us?',
      'de': 'Wurden Sie von einem Fachmann an uns verwiesen?',
      'es': '¿Algún profesional le recomendó contactarnos?',
      'fr': 'Un professionnel vous a-t-il recommandé chez nous ?',
    },
    '44639e0e': {
      'en': 'Creating your personalized haircare program',
      'de': 'Erstellen Sie Ihr persönliches Haarpflegeprogramm',
      'es': 'Creando tu programa de cuidado del cabello personalizado',
      'fr': 'Créer votre programme de soins capillaires personnalisé',
    },
    'v1fdv9fv': {
      'en': 'ewew',
      'de': 'igitt',
      'es': 'puercoespín',
      'fr': 'brebis',
    },
    'k5vkwbbc': {
      'en': 'test',
      'de': 'prüfen',
      'es': 'prueba',
      'fr': 'test',
    },
    'f1qq20i3': {
      'en': '🤓 🫧 🧖‍♀️ 🌿🤷‍♀️🙌😢😥🔒🔐😌☺️🤗😣😟😯😵‍💫',
      'de': '🤓 🫧 🧖‍♀️ 🌿🤷‍♀️🙌😢😥🔒🔐😌☺️🤗',
      'es': '🤓 🫧 🧖‍♀️ 🌿🤷‍♀️🙌😢😥🔒🔐😌☺️🤗',
      'fr': '🤓 🫧 🧖‍♀️ 🌿🤷‍♀️🙌😢😥🔒🔐😌☺️🤗',
    },
    'xx1chigz': {
      'en': 'Home',
      'de': 'Home',
      'es': 'Home',
      'fr': '',
    },
  },
  // RatingQuestion_Options
  {
    '09emjmhf': {
      'en': '1',
      'de': '1',
      'es': '1',
      'fr': '1',
    },
    'jdaoyjnt': {
      'en': '2',
      'de': '2',
      'es': '2',
      'fr': '2',
    },
    'n9815tnp': {
      'en': '3',
      'de': '3',
      'es': '3',
      'fr': '3',
    },
    'bex1s1ta': {
      'en': '4',
      'de': '4',
      'es': '4',
      'fr': '4',
    },
    '3n1wpdrn': {
      'en': '5',
      'de': '5',
      'es': '5',
      'fr': '5',
    },
    'kfse574s': {
      'en': 'Not at all',
      'de': 'Gar nicht',
      'es': 'De nada',
      'fr': 'Pas du tout',
    },
    '9qrzqazn': {
      'en': 'Totally',
      'de': 'Völlig',
      'es': 'Totalmente',
      'fr': 'Totalement',
    },
  },
  // ImageBackground_QuesBodyV3
  {
    'y2h1wino': {
      'en': '4.8 out of 5',
      'de': '4,8 von 5',
      'es': '4,8 de 5',
      'fr': '4,8 sur 5',
    },
    '31eabgmc': {
      'en': '|',
      'de': '|',
      'es': '|',
      'fr': '|',
    },
    'oy280vcm': {
      'en': 'Start by selecting your goal:',
      'de': 'Beginnen Sie mit der Auswahl Ihres Ziels:',
      'es': 'Comience seleccionando su objetivo:',
      'fr': 'Commencez par sélectionner votre objectif :',
    },
    'tvid18z0': {
      'en': 'Skip the quiz',
      'de': 'Überspringen Sie das Quiz',
      'es': 'Saltar el cuestionario',
      'fr': 'Passer le quiz',
    },
  },
  // FloatingTimerDialogBox
  {
    'zrvb3vg4': {
      'en': ' 85% OFF valid for:',
      'de': '85 % Rabatt gültig für:',
      'es': '85% de descuento válido para:',
      'fr': '85% de réduction valable pour :',
    },
    'so2q35wf': {
      'en': 'Start Now',
      'de': 'Jetzt starten',
      'es': 'Empieza ahora',
      'fr': 'Commencer maintenant',
    },
  },
  // PitchBody_textImagesBodySimilar
  {
    '2uhvkbd6': {
      'en': 'Profile Summary',
      'de': 'Profilzusammenfassung',
      'es': 'Resumen del perfil',
      'fr': 'Résumé du profil',
    },
    'z41mds6x': {
      'en': 'Hair Potential',
      'de': 'Haarpotenzial',
      'es': 'Potencial del cabello',
      'fr': 'Potentiel capillaire',
    },
    'yhkzc0dh': {
      'en':
          'Based on your answers, your hair has HIGH improvement potential. Awesome! This means your hair can be improved significantly with the right routine. While spending less time and money than you currently are.',
      'de':
          'Basierend auf Ihren Antworten haben Ihre Haare ein hohes Verbesserungspotenzial. Fantastisch! Das bedeutet, dass Ihr Haar mit der richtigen Pflege deutlich verbessert werden kann. Und das bei geringerem Zeit- und Kostenaufwand als bisher.',
      'es':
          'Según tus respuestas, tu cabello tiene un gran potencial de mejora. ¡Genial! Esto significa que puedes mejorar significativamente con la rutina adecuada, invirtiendo menos tiempo y dinero que ahora.',
      'fr':
          'D\'après vos réponses, vos cheveux ont un fort potentiel d\'amélioration. Génial ! Cela signifie que vos cheveux peuvent être considérablement améliorés avec une routine adaptée, tout en dépensant moins de temps et d\'argent qu\'actuellement.',
    },
  },
  // FloatingTimerCheckout
  {
    'mtbfmoax': {
      'en': ' 85% OFF valid for:',
      'de': '85 % Rabatt gültig für:',
      'es': '85% de descuento válido para:',
      'fr': '85% de réduction valable pour :',
    },
  },
  // MultiChoiceQuestion_CheckBox
  {
    'nbepcvyq': {
      'en': 'Our hair remembers everything',
      'de': '(Wählen Sie alle zutreffenden Antworten aus)',
      'es': '(Seleccione todas las que correspondan)',
      'fr': '(Sélectionnez tout ce qui s\'applique)',
    },
    'vzfmsa5z': {
      'en': 'None of the above',
      'de': 'Nichts des oben Genannten',
      'es': 'Ninguna de las anteriores',
      'fr': 'Aucune des réponses ci-dessus',
    },
  },
  // StartLoadingComponent
  {
    '3t7mufqk': {
      'en': 'Find out if the Haircare Challenge is right for you',
      'de':
          'Finden Sie heraus, ob die Haircare Challenge das Richtige für Sie ist',
      'es':
          'Descubre si el Desafío del Cuidado del Cabello es adecuado para ti',
      'fr': 'Découvrez si le défi Haircare est fait pour vous',
    },
    '52plp8h7': {
      'en': 'Personal space loading',
      'de': 'Persönlicher Bereich wird geladen',
      'es': 'Carga de espacio personal',
      'fr': 'Chargement de l\'espace personnel',
    },
  },
  // ImageBackground_QuesBody
  {
    'ixew8z9q': {
      'en': 'DO YOU KNOW IF YOU HAVE FOLLICLE DYSFUNCTION?',
      'de': 'Beginnen Sie mit der Auswahl Ihres Ziels:',
      'es': 'Comience seleccionando su objetivo:',
      'fr': 'Commencez par sélectionner votre objectif :',
    },
    'r3fmpz9h': {
      'en': 'Skip the Quiz',
      'de': 'Überspringen Sie das Quiz',
      'es': 'Saltar el cuestionario',
      'fr': 'Passer le quiz',
    },
  },
  // PitchBody_resultLabelPitch
  {
    'oc18k0vv': {
      'en': '\n\nHere is what is happening:\n\n',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // ManualCarusell
  {
    'kyv3grhb': {
      'en':
          'Fully recommend this routine to every woman out there! The knowledge you learn from this course sets you up to healthier and better hair! The community is with you every step of the way, the videos are full of information, and the workbook helps you put things into practice. I enjoyed my experience and the change I’ve noticed in my hair. Worth every penny!',
      'de':
          'Ich kann diese Routine jeder Frau nur wärmstens empfehlen! Das Wissen aus diesem Kurs verhilft dir zu gesünderem und schönerem Haar! Die Community begleitet dich bei jedem Schritt, die Videos sind voller Informationen und das Arbeitsbuch hilft dir, die Dinge in die Praxis umzusetzen. Ich habe meine Erfahrung und die Veränderung, die ich an meinem Haar bemerkt habe, sehr genossen. Jeden Cent wert!',
      'es':
          '¡Recomiendo totalmente esta rutina a todas las mujeres! ¡Los conocimientos que aprendes en este curso te ayudarán a tener un cabello más sano y saludable! La comunidad te acompaña en cada paso del proceso, los videos están llenos de información y el manual te ayuda a poner en práctica. Disfruté mucho de la experiencia y del cambio que he notado en mi cabello. ¡Vale cada centavo!',
      'fr':
          'Je recommande vivement cette routine à toutes les femmes ! Les connaissances acquises lors de ce cours vous permettront d\'avoir des cheveux plus sains et plus beaux ! La communauté vous accompagne à chaque étape, les vidéos sont riches en informations et le cahier d\'exercices vous aide à mettre les choses en pratique. J\'ai adoré mon expérience et les changements que j\'ai constatés sur mes cheveux. Ça vaut vraiment le coup !',
    },
    '1dec8sii': {
      'en': 'Melissa Klinefelter',
      'de': 'Melissa Klinefelter',
      'es': 'Melissa Klinefelter',
      'fr': 'Melissa Klinefelter',
    },
  },
  // LoginComponent
  {
    '1e5gv14v': {
      'en': 'Your results are ready!',
      'de': 'Ihre Ergebnisse sind da!',
      'es': '¡Tus resultados están listos!',
      'fr': 'Vos résultats sont prêts !',
    },
    '9kxb0hra': {
      'en': 'Enter your details \nto unlock your full results 🔐',
      'de': 'Geben Sie Ihre Daten ein, um Ihre Ergebnisse freizuschalten 🔐',
      'es': 'Introduce tus datos para desbloquear tus resultados 🔐',
      'fr': 'Saisissez vos coordonnées\npour accéder à vos résultats 🔐',
    },
    'dhice1ou': {
      'en': 'Name',
      'de': 'Name',
      'es': 'Nombre',
      'fr': 'Nom',
    },
    '76eyp598': {
      'en': 'Email',
      'de': 'E-Mail',
      'es': 'Correo electrónico',
      'fr': 'E-mail',
    },
    '0n6w92ng': {
      'en': 'Name is required',
      'de': 'Name ist erforderlich',
      'es': 'El nombre es obligatorio',
      'fr': 'Le nom est obligatoire',
    },
    'lubgg509': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wählen Sie eine Option aus der Dropdown-Liste',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    'mzen7x7c': {
      'en': 'Email is required',
      'de': 'E-Mail ist erforderlich',
      'es': 'Se requiere correo electrónico',
      'fr': 'L\'e-mail est obligatoire',
    },
    't8czkzlo': {
      'en': 'Please enter valid email',
      'de': 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
      'es': 'Por favor ingrese un correo electrónico válido',
      'fr': 'Veuillez saisir une adresse e-mail valide',
    },
    '4lyhh2ie': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wählen Sie eine Option aus der Dropdown-Liste',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    'glfaezfb': {
      'en': 'Your info is 100% secure and never shared with third parties. ',
      'de':
          'Ihre Daten sind 100 % sicher und werden niemals an Dritte weitergegeben.',
      'es': 'Su información es 100% segura y nunca se comparte con terceros.',
      'fr':
          'Vos informations sont 100% sécurisées et ne sont jamais partagées avec des tiers.',
    },
  },
  // Final_PitchCopy
  {
    'ectisdy6': {
      'en': 'Previous discount: ',
      'de': 'Vorheriger Rabatt:',
      'es': 'Descuento anterior:',
      'fr': 'Remise précédente :',
    },
    'xqojkbzp': {
      'en': 'Get your personal plan with up to ',
      'de': 'Sichern Sie sich Ihren persönlichen Plan mit bis zu',
      'es': 'Consigue tu plan personal con hasta',
      'fr': 'Obtenez votre forfait personnel avec jusqu\'à',
    },
    '8ieqkqa5': {
      'en': ' discount',
      'de': 'Rabatt',
      'es': 'descuento',
      'fr': 'rabais',
    },
    'oj6tcmfd': {
      'en': 'Your ',
      'de': 'Dein',
      'es': 'Su',
      'fr': 'Ton',
    },
    'cf7zz2ef': {
      'en': 'Vagus Nerve Reset ',
      'de': 'Vagusnerv-Reset',
      'es': 'Restablecimiento del nervio vago',
      'fr': 'Réinitialisation du nerf vague',
    },
    'oycp2jqg': {
      'en': 'plan is ready!',
      'de': 'Plan ist fertig!',
      'es': '¡El plan está listo!',
      'fr': 'le plan est prêt !',
    },
    'zm5fkvnr': {
      'en': 'Main trigger: ',
      'de': 'Hauptauslöser:',
      'es': 'Desencadenante principal:',
      'fr': 'Déclencheur principal :',
    },
    'vpdapk4a': {
      'en': 'Wrong routine',
      'de': 'Falsche Routine',
      'es': 'Rutina equivocada',
      'fr': 'Mauvaise routine',
    },
    '8nm2ndrh': {
      'en': 'Plan focus:',
      'de': 'Planschwerpunkt:',
      'es': 'Enfoque del plan:',
      'fr': 'Objectif du plan :',
    },
    'ncal8jc0': {
      'en': 'MOST POPULAR',
      'de': 'AM POPULÄRSTEN',
      'es': 'MÁS POPULAR',
      'fr': 'LE PLUS POPULAIRE',
    },
    '4xbu1770': {
      'en': '\$',
      'de': '\$',
      'es': '\$',
      'fr': '\$',
    },
    'lhtbg9hr': {
      'en': '0',
      'de': '0',
      'es': '0',
      'fr': '0',
    },
    '91z902ra': {
      'en':
          'People using our plan for 12 weeks achieve twice as many results as for 4 weeks',
      'de':
          'Menschen, die unseren Plan 12 Wochen lang anwenden, erzielen doppelt so viele Ergebnisse wie Menschen, die ihn 4 Wochen lang anwenden.',
      'es':
          'Las personas que utilizan nuestro plan durante 12 semanas obtienen el doble de resultados que durante 4 semanas.',
      'fr':
          'Les personnes qui utilisent notre plan pendant 12 semaines obtiennent deux fois plus de résultats que pendant 4 semaines',
    },
    '92uxjegs': {
      'en': 'GET MY PLAN',
      'de': 'MEINEN PLAN ERHALTEN',
      'es': 'OBTENGA MI PLAN',
      'fr': 'OBTENIR MON PLAN',
    },
  },
  // skip_dialog
  {
    '0cja6uh2': {
      'en': '⚠️ Before you continue...',
      'de': '⚠️ Bevor Sie fortfahren …',
      'es': '⚠️ Antes de continuar...',
      'fr': '⚠️ Avant de continuer...',
    },
    'biuiym7a': {
      'en':
          'Only skip the quiz if you\'ve previously completed it, as it\'s required to create a personalized routine based on your hair condition, lifestyle, and other key factors.',
      'de':
          'Überspringen Sie das Quiz nur, wenn Sie es bereits abgeschlossen haben, da es erforderlich ist, eine personalisierte Routine basierend auf Ihrem Haarzustand, Ihrem Lebensstil und anderen wichtigen Faktoren zu erstellen.',
      'es':
          'Omite el cuestionario solo si ya lo has completado previamente, ya que es necesario para crear una rutina personalizada en función de la condición de tu cabello, tu estilo de vida y otros factores clave.',
      'fr':
          'Ne sautez le quiz que si vous l\'avez déjà terminé, car il est nécessaire de créer une routine personnalisée en fonction de l\'état de vos cheveux, de votre style de vie et d\'autres facteurs clés.',
    },
    '6x7g4z0e': {
      'en': 'BACK TO QUIZ',
      'de': 'ZURÜCK ZUM QUIZ',
      'es': 'VOLVER AL CUESTIONARIO',
      'fr': 'RETOUR AU QUIZ',
    },
    'jn6yshoa': {
      'en': 'SKIP QUIZ',
      'de': 'QUIZ ÜBERSPRINGEN',
      'es': 'SALTAR LA PRUEBA',
      'fr': 'SAUTER LE QUIZ',
    },
  },
  // LoadingScreen_beforeResult
  {
    'thdd4opu': {
      'en': 'Restore your hair follicle health within days.',
      'de': 'Das einzige Haarpflegeprogramm, das Sie jemals brauchen werden',
      'es': 'El único programa de cuidado del cabello que necesitarás',
      'fr': 'Le seul programme de soins capillaires dont vous aurez besoin',
    },
  },
  // PitchBody_simpleTextImagesBody
  {
    'u7c6uom7': {
      'en': 'Follicle dysfunction probability:',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qgq1r05e': {
      'en': 'High ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'h3j1paw8': {
      'en': '\n\nThe fact that ',
      'de': 'von Frauen, die mit',
      'es': 'de mujeres, luchando con',
      'fr': 'des femmes aux prises avec',
    },
  },
  // pitch_plan_dialogCopy
  {
    'tdwe6nzm': {
      'en': 'Your Haircare Challenge Plan',
      'de': 'Ihr Haarpflege-Challenge-Plan',
      'es': 'Tu plan de desafío para el cuidado del cabello',
      'fr': 'Votre plan de défi de soins capillaires',
    },
    'dovft1qw': {
      'en': 'YOUR DISCOUNT',
      'de': 'IHR RABATT',
      'es': 'TU DESCUENTO',
      'fr': 'VOTRE REMISE',
    },
    'tb5ex1i2': {
      'en': ' RESERVED FOR',
      'de': 'RESERVIERT FÜR',
      'es': 'RESERVADO PARA',
      'fr': 'RÉSERVÉ À',
    },
    '7ngdtn9t': {
      'en': '14 Day Plan',
      'de': '14-Tage-Plan',
      'es': 'Plan de 14 días',
      'fr': 'Plan de 14 jours',
    },
    'h0etcavm': {
      'en': 'Full Access',
      'de': 'Vollzugriff',
      'es': 'Acceso completo',
      'fr': 'Accès complet',
    },
    'oqk57yfn': {
      'en': 'Based on your profile, we\'ve added these modules to your plan ',
      'de':
          'Basierend auf Ihrem Profil haben wir diese Module zu Ihrem Plan hinzugefügt',
      'es': 'En función de tu perfil, hemos añadido estos módulos a tu plan',
      'fr':
          'En fonction de votre profil, nous avons ajouté ces modules à votre plan',
    },
    'fw80v5mn': {
      'en': 'to ensure success:',
      'de': 'um den Erfolg sicherzustellen:',
      'es': 'Para garantizar el éxito:',
      'fr': 'pour assurer le succès :',
    },
    'jnsh4y8d': {
      'en': 'START NOW →',
      'de': 'JETZT STARTEN →',
      'es': 'COMIENZA AHORA →',
      'fr': 'COMMENCEZ MAINTENANT →',
    },
  },
  // MultiChoiceWithImageQuestion_CheckBox
  {
    '7o5y8tc0': {
      'en': 'Select all that apply',
      'de': 'Wählen Sie alle zutreffenden Antworten aus',
      'es': 'Seleccione todas las que correspondan',
      'fr': 'Sélectionnez tout ce qui s\'applique',
    },
    '7tkotzl5': {
      'en': 'None of the above',
      'de': 'Nichts des oben Genannten',
      'es': 'Ninguna de las anteriores',
      'fr': 'Aucune des réponses ci-dessus',
    },
  },
  // MultiChoiceWithImageQuestion_CheckBoxPractices
  {
    '907jgrxi': {
      'en': '(Select all that apply)',
      'de': '(Wählen Sie alle zutreffenden Antworten aus)',
      'es': '(Seleccione todas las que correspondan)',
      'fr': '(Sélectionnez tout ce qui s\'applique)',
    },
    'ig7rz0ud': {
      'en': 'None of the above',
      'de': 'Nichts des oben Genannten',
      'es': 'Ninguna de las anteriores',
      'fr': 'Aucune des réponses ci-dessus',
    },
  },
  // Dashboard
  {
    'qm88njuv': {
      'en': 'You are a perfect fit for the Haircare Challenge 😍',
      'de': 'Du bist perfekt für die Haircare Challenge 😍',
      'es': 'Eres perfecto para el reto del cuidado del cabello 😍',
      'fr': 'Vous êtes la personne idéale pour le Haircare Challenge 😍',
    },
    '26c1jnac': {
      'en': 'Your matching score is:',
      'de': 'Ihr Matching-Score ist',
      'es': 'Tu puntuación de coincidencia es',
      'fr': 'Votre score de correspondance est',
    },
    'aq4pinvd': {
      'en': 'Your hair transformation timeline:',
      'de': 'Zeitplan für Ihre Haartransformation:',
      'es': 'Cronología de tu transformación capilar:',
      'fr': 'Chronologie de votre transformation capillaire :',
    },
    'unnguajk': {
      'en': '✅',
      'de': '✅',
      'es': '✅',
      'fr': '✅',
    },
    'gupt5mjs': {
      'en':
          'Target the root causes of your hair issues and stop them from coming back.',
      'de':
          'Bekämpfen Sie die Ursachen Ihrer Haarprobleme und verhindern Sie, dass sie wieder auftreten.',
      'es':
          'Aborde las causas fundamentales de sus problemas capilares y evite que regresen.',
      'fr':
          'Ciblez les causes profondes de vos problèmes capillaires et empêchez-les de revenir.',
    },
    '6gx8s01a': {
      'en': '✅',
      'de': '✅',
      'es': '✅',
      'fr': '✅',
    },
    'begqgauj': {
      'en':
          'Build a personalized, easy-to-follow haircare plan tailored to your unique needs.',
      'de':
          'Erstellen Sie einen personalisierten, leicht verständlichen Haarpflegeplan, der auf Ihre individuellen Bedürfnisse zugeschnitten ist.',
      'es':
          'Cree un plan de cuidado del cabello personalizado y fácil de seguir adaptado a sus necesidades únicas.',
      'fr':
          'Créez un plan de soins capillaires personnalisé et facile à suivre, adapté à vos besoins uniques.',
    },
    'mdb5vygy': {
      'en': '✅',
      'de': '✅',
      'es': '✅',
      'fr': '✅',
    },
    'qopcc4n9': {
      'en':
          'Create your own gentle, DIY shampoo & conditioner for lasting results',
      'de':
          'Kreieren Sie Ihr eigenes sanftes DIY-Shampoo und Ihre Spülung für langanhaltende Ergebnisse',
      'es':
          'Crea tu propio champú y acondicionador suave y casero para obtener resultados duraderos.',
      'fr':
          'Créez votre propre shampooing et après-shampooing doux et DIY pour des résultats durables',
    },
    'tvn54o9f': {
      'en': 'JOIN THE CHALLENGE',
      'de': 'NEHMEN SIE AN DER HERAUSFORDERUNG TEIL',
      'es': 'ÚNETE AL RETO',
      'fr': 'REJOIGNEZ LE DÉFI',
    },
    '2cdo81nl': {
      'en': '91,000+ women ',
      'de': '91.000+ Frauen',
      'es': 'más de 91.000 mujeres',
      'fr': 'plus de 91 000 femmes',
    },
    'clhaelj4': {
      'en': 'have taken this challenge, and ',
      'de': 'haben diese Herausforderung angenommen und',
      'es': 'han aceptado este desafío y',
      'fr': 'ont relevé ce défi, et',
    },
    'fwse24sg': {
      'en': '92% of finishers said “It has changed their life”.',
      'de': '92 % der Teilnehmer sagten: „Es hat ihr Leben verändert.“',
      'es':
          'El 92% de los que finalizaron el curso afirmaron: “Les ha cambiado la vida”.',
      'fr':
          '92 % des personnes ayant terminé le programme ont déclaré : « Cela a changé leur vie ».',
    },
    'phsineyb': {
      'en': 'START MY CHALLENGE',
      'de': 'MEINE HERAUSFORDERUNG STARTEN',
      'es': 'COMIENZA MI RETO',
      'fr': 'COMMENCEZ MON DÉFI',
    },
    'x0h469el': {
      'en': 'Based on your answers, you just need',
      'de': 'Basierend auf Ihren Antworten müssen Sie nur',
      'es': 'En base a tus respuestas, solo necesitas',
      'fr': 'En fonction de vos réponses, il vous suffit de',
    },
    'u03zkhmn': {
      'en': '\n10 min a day, for 14 days\n',
      'de': '10 Minuten pro Tag, 14 Tage lang',
      'es': '10 minutos al día, durante 14 días',
      'fr': '10 minutes par jour, pendant 14 jours',
    },
    'lxtttebt': {
      'en':
          'to get beautiful and healthy hair that turns heads and boosts your confidence every single day.',
      'de':
          'um schönes und gesundes Haar zu bekommen, das die Blicke auf sich zieht und Ihr Selbstvertrauen jeden Tag stärkt.',
      'es':
          'para conseguir un cabello bello y saludable que llame la atención y aumente tu confianza todos los días.',
      'fr':
          'pour obtenir des cheveux beaux et sains qui font tourner les têtes et renforcent votre confiance chaque jour.',
    },
    'rpb2l5tr': {
      'en': '100%\nResults',
      'de': '100 %\nErgebnisse',
      'es': '100%\nResultados',
      'fr': '100 %\nRésultats',
    },
    '7qu4hw6f': {
      'en': '0%\nHassle',
      'de': '0 %\nÄrger',
      'es': '0%\nProblemas',
      'fr': '0 %\nProblèmes',
    },
    'on4egm7h': {
      'en': 'Science-based and ',
      'de': 'Wissenschaftlich fundierte und',
      'es': 'Basado en la ciencia y',
      'fr': 'Fondé sur la science et',
    },
    '5zr2seie': {
      'en': 'reviewed by haircare experts.',
      'de': 'Von Haarpflegeexperten geprüft.',
      'es': 'Revisado por expertos en el cuidado del cabello.',
      'fr': 'examiné par des experts en soins capillaires.',
    },
    '7t1iikxr': {
      'en': 'Get a ',
      'de': 'Holen Sie sich ein',
      'es': 'Conseguir una',
      'fr': 'Obtenez un',
    },
    'hv2znn3j': {
      'en': 'nutrient-rich meal plan ',
      'de': 'nährstoffreicher Speiseplan',
      'es': 'plan de alimentación rico en nutrientes',
      'fr': 'plan de repas riche en nutriments',
    },
    'q9istz0v': {
      'en': 'to minimise hair loss and enhance hair thickness.',
      'de': 'um Haarausfall zu minimieren und die Haardichte zu verbessern.',
      'es':
          'Para minimizar la caída del cabello y mejorar el grosor del cabello.',
      'fr': 'pour minimiser la perte de cheveux et améliorer leur épaisseur.',
    },
    'yqzvlhso': {
      'en': 'Save thousands ',
      'de': 'Sparen Sie Tausende',
      'es': 'Ahorre miles',
      'fr': 'Économisez des milliers',
    },
    '16qkzkbg': {
      'en': 'on products and salon treatments you won\'t need anymore.',
      'de': 'für Produkte und Salonbehandlungen, die Sie nicht mehr benötigen.',
      'es': 'sobre productos y tratamientos de salón que ya no necesitarás.',
      'fr':
          'sur les produits et soins de salon dont vous n\'aurez plus besoin.',
    },
    '8p79eqjq': {
      'en': 'START MY CHALLENGE',
      'de': 'MEINE HERAUSFORDERUNG STARTEN',
      'es': 'COMIENZA MI RETO',
      'fr': 'COMMENCEZ MON DÉFI',
    },
    '6kg20sml': {
      'en': '100% Refund guarantee | No Questions Asked',
      'de': '100% Geld-zurück-Garantie | Keine Fragen gestellt',
      'es': 'Garantía de reembolso del 100 % | Sin preguntas',
      'fr': 'Garantie de remboursement à 100 % | Aucune question posée',
    },
  },
  // Final_Pitch
  {
    '0r9t3oy8': {
      'en': 'We\'ve found the right \nHaircare Program for you 🎉',
      'de': 'Wir haben das richtige Haarpflegeprogramm für Sie gefunden 🎉',
      'es':
          'Hemos encontrado el programa de cuidado capilar perfecto para ti 🎉',
      'fr':
          'Nous avons trouvé le programme de soins capillaires idéal pour vous 🎉',
    },
    '817pt5y7': {
      'en': 'Personal plan for ',
      'de': 'Persönlicher Plan für',
      'es': 'Plan personal para',
      'fr': 'Plan personnel pour',
    },
    'itcort7o': {
      'en': ' has been reserved.',
      'de': 'wurde reserviert.',
      'es': 'Ha sido reservado.',
      'fr': 'a été réservé.',
    },
    '9wp0qw0h': {
      'en': 'Holistic Haircare Routine ',
      'de': 'Ganzheitliche Haarpflegeroutine',
      'es': 'Rutina holística de cuidado capilar',
      'fr': 'Routine de soins capillaires holistiques',
    },
    'y3g6sgpk': {
      'en': 'plan is ready!',
      'de': 'Plan ist fertig!',
      'es': '¡El plan está listo!',
      'fr': 'le plan est prêt !',
    },
    'nlz1clot': {
      'en': 'Start today and become unrecognizable in 14 days with ',
      'de': 'Starten Sie noch heute und werden Sie in 14 Tagen unkenntlich mit',
      'es': 'Empieza hoy y vuélvete irreconocible en 14 días con',
      'fr': 'Commencez aujourd\'hui et devenez méconnaissable en 14 jours avec',
    },
    'ekwd1cyb': {
      'en': 'Main trigger: ',
      'de': 'Hauptauslöser:',
      'es': 'Desencadenante principal:',
      'fr': 'Déclencheur principal :',
    },
    '2fc0jc34': {
      'en': 'Wrong routine',
      'de': 'Falsche Routine',
      'es': 'Rutina equivocada',
      'fr': 'Mauvaise routine',
    },
    '9vlngh5n': {
      'en': 'Plan focus:',
      'de': 'Planschwerpunkt:',
      'es': 'Enfoque del plan:',
      'fr': 'Objectif du plan :',
    },
    're08tcmi': {
      'en': 'YOUR PERSONALIZED PLAN',
      'de': 'IHR PERSONALISIERTER PLAN',
      'es': 'TU PLAN PERSONALIZADO',
      'fr': 'VOTRE PLAN PERSONNALISÉ',
    },
    'bubj1rw2': {
      'en': '\$',
      'de': '\$',
      'es': '\$',
      'fr': '\$',
    },
    'g1p5u51r': {
      'en': 'People using this program see visible results in 14 days.',
      'de':
          'Personen, die dieses Programm verwenden, sehen innerhalb von 14 Tagen sichtbare Ergebnisse.',
      'es':
          'Las personas que utilizan este programa ven resultados visibles en 14 días.',
      'fr':
          'Les personnes utilisant ce programme voient des résultats visibles en 14 jours.',
    },
    '99ghm8vs': {
      'en': 'GET MY PLAN',
      'de': 'MEINEN PLAN ERHALTEN',
      'es': 'OBTENGA MI PLAN',
      'fr': 'OBTENIR MON PLAN',
    },
  },
  // pitch_plan_dialog
  {
    'hgyl4nrl': {
      'en': 'Your Haircare Challenge Plan',
      'de': 'Ihr Haarpflege-Challenge-Plan',
      'es': 'Tu plan de desafío para el cuidado del cabello',
      'fr': 'Votre plan de défi de soins capillaires',
    },
    'b1ck4ulz': {
      'en': 'YOUR DISCOUNT',
      'de': 'IHR RABATT',
      'es': 'TU DESCUENTO',
      'fr': 'VOTRE REMISE',
    },
    'vu8o4qzc': {
      'en': ' IS STILL RESERVED FOR:',
      'de': 'IST NOCH RESERVIERT FÜR:',
      'es': 'TODAVÍA ESTÁ RESERVADO PARA:',
      'fr': 'EST TOUJOURS RÉSERVÉ À :',
    },
    '5ths0qr4': {
      'en': '14 Day Plan',
      'de': '14-Tage-Plan',
      'es': 'Plan de 14 días',
      'fr': 'Plan de 14 jours',
    },
    'iu28pmt3': {
      'en': 'Full Access',
      'de': 'Vollzugriff',
      'es': 'Acceso completo',
      'fr': 'Accès complet',
    },
    'ichnww2b': {
      'en': 'Based on your profile, we\'ve added these modules to your plan ',
      'de':
          'Basierend auf Ihrem Profil haben wir diese Module zu Ihrem Plan hinzugefügt',
      'es': 'En función de tu perfil, hemos añadido estos módulos a tu plan',
      'fr':
          'En fonction de votre profil, nous avons ajouté ces modules à votre plan',
    },
    'h4mmue8a': {
      'en': 'to ensure success:',
      'de': 'um den Erfolg sicherzustellen:',
      'es': 'Para garantizar el éxito:',
      'fr': 'pour assurer le succès :',
    },
    '32vzsk0t': {
      'en': 'START NOW →',
      'de': 'JETZT STARTEN →',
      'es': 'COMIENZA AHORA →',
      'fr': 'COMMENCEZ MAINTENANT →',
    },
  },
  // ImageBackground_QuesBodyV2
  {
    'rvqxeq7r': {
      'en': 'Start by selecting your goal:',
      'de': 'Beginnen Sie mit der Auswahl Ihres Ziels:',
      'es': 'Comience seleccionando su objetivo:',
      'fr': 'Commencez par sélectionner votre objectif :',
    },
    'fi8xv3qb': {
      'en': 'I want BOTH',
      'de': 'Ich will BEIDES',
      'es': 'Quiero AMBOS',
      'fr': 'Je veux les DEUX',
    },
    '6laxeb4h': {
      'en': 'Skip',
      'de': 'Überspringen',
      'es': 'Saltar',
      'fr': 'Sauter',
    },
  },
  // Miscellaneous
  {
    '1eqxhevg': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ic8jhu9j': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ec8rm8tk': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xxhl0wn1': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'm8nqwxb1': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'revbq5qq': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '09ukt3c8': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1gug1sgp': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'c6bnul88': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hwh30sl9': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'z4ox7u3f': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fhsi3i9h': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'mmvr2hkb': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'uiz5gk5w': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ba5zeg7d': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'yazkokus': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2ugi4962': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8bsv7vn3': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'nelocmqn': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5p3tyhke': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '703vur6b': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '7s69vfg6': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qndl2sh5': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'g4s5q2ha': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '04n16m28': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
