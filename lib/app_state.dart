import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<String> _dummyData = [
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt',
    'Hallo Welt'
  ];
  List<String> get dummyData => _dummyData;
  set dummyData(List<String> value) {
    _dummyData = value;
  }

  void addToDummyData(String value) {
    dummyData.add(value);
  }

  void removeFromDummyData(String value) {
    dummyData.remove(value);
  }

  void removeAtIndexFromDummyData(int index) {
    dummyData.removeAt(index);
  }

  void updateDummyDataAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    dummyData[index] = updateFn(_dummyData[index]);
  }

  void insertAtIndexInDummyData(int index, String value) {
    dummyData.insert(index, value);
  }

  List<String> _beforeLoadingData = [
    'Checke deinen Haarzustand',
    'Analysiere deine Routine',
    'Prüfe, ob die Challenge zu dir passt'
  ];
  List<String> get beforeLoadingData => _beforeLoadingData;
  set beforeLoadingData(List<String> value) {
    _beforeLoadingData = value;
  }

  void addToBeforeLoadingData(String value) {
    beforeLoadingData.add(value);
  }

  void removeFromBeforeLoadingData(String value) {
    beforeLoadingData.remove(value);
  }

  void removeAtIndexFromBeforeLoadingData(int index) {
    beforeLoadingData.removeAt(index);
  }

  void updateBeforeLoadingDataAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    beforeLoadingData[index] = updateFn(_beforeLoadingData[index]);
  }

  void insertAtIndexInBeforeLoadingData(int index, String value) {
    beforeLoadingData.insert(index, value);
  }

  ///  Multiple-choice answer with check box
  List<MultiChoiceCheckBoxStruct> _multiChoiceAnswer = [
    MultiChoiceCheckBoxStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Hitze-Styling\",\"checkBox\":\"false\"}')),
    MultiChoiceCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Bleichen / Haarfarbe\",\"checkBox\":\"false\"}')),
    MultiChoiceCheckBoxStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Sonneneinstrahlung\",\"checkBox\":\"false\"}')),
    MultiChoiceCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)\",\"checkBox\":\"false\"}'))
  ];
  List<MultiChoiceCheckBoxStruct> get multiChoiceAnswer => _multiChoiceAnswer;
  set multiChoiceAnswer(List<MultiChoiceCheckBoxStruct> value) {
    _multiChoiceAnswer = value;
  }

  void addToMultiChoiceAnswer(MultiChoiceCheckBoxStruct value) {
    multiChoiceAnswer.add(value);
  }

  void removeFromMultiChoiceAnswer(MultiChoiceCheckBoxStruct value) {
    multiChoiceAnswer.remove(value);
  }

  void removeAtIndexFromMultiChoiceAnswer(int index) {
    multiChoiceAnswer.removeAt(index);
  }

  void updateMultiChoiceAnswerAtIndex(
    int index,
    MultiChoiceCheckBoxStruct Function(MultiChoiceCheckBoxStruct) updateFn,
  ) {
    multiChoiceAnswer[index] = updateFn(_multiChoiceAnswer[index]);
  }

  void insertAtIndexInMultiChoiceAnswer(
      int index, MultiChoiceCheckBoxStruct value) {
    multiChoiceAnswer.insert(index, value);
  }

  /// Answer title and description data.
  List<AnswerWithTitleAndDescriptionStruct> _answerWithTitleAndDescription = [
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Keine spezielle Ernährung\",\"description\":\"Ich habe keine Ernährungseinschränkungen\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Vegetarisch\",\"description\":\"Ich verzichte auf Fleisch, Fisch und Geflügel\\nprodukte\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Glutenfrei\",\"description\":\"Ich meide Weizen, Gerste, Roggen oder andere Getreide\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Vegan\",\"description\":\"Ich vermeide alle tierischen Produkte: Fleisch,\\nEier, Milchprodukte usw. Nur pflanzliche Lebensmittel\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Andere\",\"description\":\"\"}'))
  ];
  List<AnswerWithTitleAndDescriptionStruct> get answerWithTitleAndDescription =>
      _answerWithTitleAndDescription;
  set answerWithTitleAndDescription(
      List<AnswerWithTitleAndDescriptionStruct> value) {
    _answerWithTitleAndDescription = value;
  }

  void addToAnswerWithTitleAndDescription(
      AnswerWithTitleAndDescriptionStruct value) {
    answerWithTitleAndDescription.add(value);
  }

  void removeFromAnswerWithTitleAndDescription(
      AnswerWithTitleAndDescriptionStruct value) {
    answerWithTitleAndDescription.remove(value);
  }

  void removeAtIndexFromAnswerWithTitleAndDescription(int index) {
    answerWithTitleAndDescription.removeAt(index);
  }

  void updateAnswerWithTitleAndDescriptionAtIndex(
    int index,
    AnswerWithTitleAndDescriptionStruct Function(
            AnswerWithTitleAndDescriptionStruct)
        updateFn,
  ) {
    answerWithTitleAndDescription[index] =
        updateFn(_answerWithTitleAndDescription[index]);
  }

  void insertAtIndexInAnswerWithTitleAndDescription(
      int index, AnswerWithTitleAndDescriptionStruct value) {
    answerWithTitleAndDescription.insert(index, value);
  }

  /// Question with single-choice answer Image
  List<ImageAnswerStruct> _answerWithImageChoice = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Antwort 1\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Antwort 2\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Antwort 3\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Antwort 4\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://picsum.photos/seed/515/600\",\"answer\":\"Hallo Welt\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://picsum.photos/seed/152/600\",\"answer\":\"Hallo Welt\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://picsum.photos/seed/258/600\",\"answer\":\"Hallo Welt\"}'))
  ];
  List<ImageAnswerStruct> get answerWithImageChoice => _answerWithImageChoice;
  set answerWithImageChoice(List<ImageAnswerStruct> value) {
    _answerWithImageChoice = value;
  }

  void addToAnswerWithImageChoice(ImageAnswerStruct value) {
    answerWithImageChoice.add(value);
  }

  void removeFromAnswerWithImageChoice(ImageAnswerStruct value) {
    answerWithImageChoice.remove(value);
  }

  void removeAtIndexFromAnswerWithImageChoice(int index) {
    answerWithImageChoice.removeAt(index);
  }

  void updateAnswerWithImageChoiceAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    answerWithImageChoice[index] = updateFn(_answerWithImageChoice[index]);
  }

  void insertAtIndexInAnswerWithImageChoice(
      int index, ImageAnswerStruct value) {
    answerWithImageChoice.insert(index, value);
  }

  /// Question with answer.
  List<AnswerStruct> _answer = [
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Hitze-Styling\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Bleichen / Haarfarbe\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Häufiges Schwimmen\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Sonneneinstrahlung\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(
        jsonDecode('{\"answer\":\"Nichts davon\"}'))
  ];
  List<AnswerStruct> get answer => _answer;
  set answer(List<AnswerStruct> value) {
    _answer = value;
  }

  void addToAnswer(AnswerStruct value) {
    answer.add(value);
  }

  void removeFromAnswer(AnswerStruct value) {
    answer.remove(value);
  }

  void removeAtIndexFromAnswer(int index) {
    answer.removeAt(index);
  }

  void updateAnswerAtIndex(
    int index,
    AnswerStruct Function(AnswerStruct) updateFn,
  ) {
    answer[index] = updateFn(_answer[index]);
  }

  void insertAtIndexInAnswer(int index, AnswerStruct value) {
    answer.insert(index, value);
  }

  int _quizIndex = 0;
  int get quizIndex => _quizIndex;
  set quizIndex(int value) {
    _quizIndex = value;
  }

  List<ImageAnswerStruct> _hairConcern = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Hair%20loss.webp\",\"answer\":\"Haarausfall oder dünner werdendes Haar\",\"id\":\"concern_hairloss\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Damage%20Hair.webp\",\"answer\":\"Schäden durch Färben, Hitze oder chemische Behandlungen\",\"id\":\"concern_damage\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Irritation.webp\",\"answer\":\"Kopfhautreizungen oder Schuppen\",\"id\":\"concern_scalp\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Split%20ends.webp\",\"answer\":\"Spliss, Frizz und Trockenheit\",\"id\":\"concern_splitends\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20other.webp\",\"answer\":\"Andere, gemischte Probleme\",\"id\":\"concern_mixed\",\"type\":\"hairConcern\"}'))
  ];
  List<ImageAnswerStruct> get hairConcern => _hairConcern;
  set hairConcern(List<ImageAnswerStruct> value) {
    _hairConcern = value;
  }

  void addToHairConcern(ImageAnswerStruct value) {
    hairConcern.add(value);
  }

  void removeFromHairConcern(ImageAnswerStruct value) {
    hairConcern.remove(value);
  }

  void removeAtIndexFromHairConcern(int index) {
    hairConcern.removeAt(index);
  }

  void updateHairConcernAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    hairConcern[index] = updateFn(_hairConcern[index]);
  }

  void insertAtIndexInHairConcern(int index, ImageAnswerStruct value) {
    hairConcern.insert(index, value);
  }

  /// Start loading screen data
  List<String> _loadingWidget = [
    '🚫 Schluss mit versteckten schädlichen Inhaltsstoffen.',
    '🌱 Weniger Haarausfall und neue Babyhaare.',
    '✅ Spliss, der nicht wiederkommt.',
    '💛 Das Beste aus der Wissenschaft, einfach für zu Hause.'
  ];
  List<String> get loadingWidget => _loadingWidget;
  set loadingWidget(List<String> value) {
    _loadingWidget = value;
  }

  void addToLoadingWidget(String value) {
    loadingWidget.add(value);
  }

  void removeFromLoadingWidget(String value) {
    loadingWidget.remove(value);
  }

  void removeAtIndexFromLoadingWidget(int index) {
    loadingWidget.removeAt(index);
  }

  void updateLoadingWidgetAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    loadingWidget[index] = updateFn(_loadingWidget[index]);
  }

  void insertAtIndexInLoadingWidget(int index, String value) {
    loadingWidget.insert(index, value);
  }

  /// Multi select checkbox with images
  List<MultiChoiceWithImagesCheckBoxStruct> _multiChoiceWithImage = [
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Rosmarinöl ist ein Universalmittel\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Kokosöl ist das beste für die Haare\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Reiswasser lässt deine Haare schneller wachsen\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Natürliche und biologische Produkte sind besser\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Haare können wie die Haut heilen\",\"checklBox\":\"false\"}'))
  ];
  List<MultiChoiceWithImagesCheckBoxStruct> get multiChoiceWithImage =>
      _multiChoiceWithImage;
  set multiChoiceWithImage(List<MultiChoiceWithImagesCheckBoxStruct> value) {
    _multiChoiceWithImage = value;
  }

  void addToMultiChoiceWithImage(MultiChoiceWithImagesCheckBoxStruct value) {
    multiChoiceWithImage.add(value);
  }

  void removeFromMultiChoiceWithImage(
      MultiChoiceWithImagesCheckBoxStruct value) {
    multiChoiceWithImage.remove(value);
  }

  void removeAtIndexFromMultiChoiceWithImage(int index) {
    multiChoiceWithImage.removeAt(index);
  }

  void updateMultiChoiceWithImageAtIndex(
    int index,
    MultiChoiceWithImagesCheckBoxStruct Function(
            MultiChoiceWithImagesCheckBoxStruct)
        updateFn,
  ) {
    multiChoiceWithImage[index] = updateFn(_multiChoiceWithImage[index]);
  }

  void insertAtIndexInMultiChoiceWithImage(
      int index, MultiChoiceWithImagesCheckBoxStruct value) {
    multiChoiceWithImage.insert(index, value);
  }

  List<String> _imageList = [
    'https://assets.hairqare.co/Hair-Routine_TP-Updated.webp',
    'https://assets.hairqare.co/illustration-tp-91.webp',
    'https://assets.hairqare.co/Hair%20Routine-04.webp',
    'https://assets.hairqare.co/Hair%20Routine-05.webp'
  ];
  List<String> get imageList => _imageList;
  set imageList(List<String> value) {
    _imageList = value;
  }

  void addToImageList(String value) {
    imageList.add(value);
  }

  void removeFromImageList(String value) {
    imageList.remove(value);
  }

  void removeAtIndexFromImageList(int index) {
    imageList.removeAt(index);
  }

  void updateImageListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    imageList[index] = updateFn(_imageList[index]);
  }

  void insertAtIndexInImageList(int index, String value) {
    imageList.insert(index, value);
  }

  /// Answer show with their animated additional info just like title and
  /// description.
  List<AnswerWithAdditionalInfoStruct> _AnswerWithAdditionalInfo = [
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Niemals\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Ein ausgeglichener Geist führt zu einem gesunden Leben\",\"AnswerDescription\":\"Studien zeigen, dass ein stressfreier Lebensstil das allgemeine Wohlbefinden steigert, die Produktivität fördert und die geistige Klarheit verbessert.\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Selten\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Stress bewältigen, bevor er dich bewältigt\",\"AnswerDescription\":\"Während gelegentlicher Stress normal ist, kann das frühzeitige Angehen kleiner Stressfaktoren verhindern, dass sie sich aufbauen.\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Oft\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Stress verstehen und reduzieren\",\"AnswerDescription\":\"Studien zeigen, dass chronischer Stress sowohl die körperliche als auch die geistige Gesundheit beeinträchtigen kann.\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ständig\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Geistiges Wohlbefinden priorisieren\",\"AnswerDescription\":\"Wenn Stress ein ständiger Teil des Lebens ist, kann es hilfreich sein, strukturierte Stressbewältigungsstrategien zu erkunden, wie Therapie, Achtsamkeitstraining oder geführte Entspannungstechniken.\"}'))
  ];
  List<AnswerWithAdditionalInfoStruct> get AnswerWithAdditionalInfo =>
      _AnswerWithAdditionalInfo;
  set AnswerWithAdditionalInfo(List<AnswerWithAdditionalInfoStruct> value) {
    _AnswerWithAdditionalInfo = value;
  }

  void addToAnswerWithAdditionalInfo(AnswerWithAdditionalInfoStruct value) {
    AnswerWithAdditionalInfo.add(value);
  }

  void removeFromAnswerWithAdditionalInfo(
      AnswerWithAdditionalInfoStruct value) {
    AnswerWithAdditionalInfo.remove(value);
  }

  void removeAtIndexFromAnswerWithAdditionalInfo(int index) {
    AnswerWithAdditionalInfo.removeAt(index);
  }

  void updateAnswerWithAdditionalInfoAtIndex(
    int index,
    AnswerWithAdditionalInfoStruct Function(AnswerWithAdditionalInfoStruct)
        updateFn,
  ) {
    AnswerWithAdditionalInfo[index] =
        updateFn(_AnswerWithAdditionalInfo[index]);
  }

  void insertAtIndexInAnswerWithAdditionalInfo(
      int index, AnswerWithAdditionalInfoStruct value) {
    AnswerWithAdditionalInfo.insert(index, value);
  }

  /// Plan data list
  List<PlanStruct> _PlanData = [
    PlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"14-Tage-Challenge\",\"actualPrice\":\"300\",\"discountedPrice\":\"37\",\"perDayActualPrice\":\"300\",\"discountedPerDayPrice\":\"85\",\"isPopularPlan\":\"true\"}'))
  ];
  List<PlanStruct> get PlanData => _PlanData;
  set PlanData(List<PlanStruct> value) {
    _PlanData = value;
  }

  void addToPlanData(PlanStruct value) {
    PlanData.add(value);
  }

  void removeFromPlanData(PlanStruct value) {
    PlanData.remove(value);
  }

  void removeAtIndexFromPlanData(int index) {
    PlanData.removeAt(index);
  }

  void updatePlanDataAtIndex(
    int index,
    PlanStruct Function(PlanStruct) updateFn,
  ) {
    PlanData[index] = updateFn(_PlanData[index]);
  }

  void insertAtIndexInPlanData(int index, PlanStruct value) {
    PlanData.insert(index, value);
  }

  /// Personal plan dialog data list
  List<PersonalPlanStruct> _personalPlan = [
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"14-Tage Haarpflege-Tagebuch & Vorlagen\",\"price\":\"29\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"DIY Luxus-Shampoo Workshop\",\"price\":\"39\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Haarpflege No-Go Inhaltsstoffe Liste\",\"price\":\"35\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Komplettes Haar-Wellness Handbuch\",\"price\":\"29\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Silikone & Sulfate - Clevere Anwendung\",\"price\":\"29\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"30-Tage Haar-Achtsamkeits-Erfahrung\",\"price\":\"15\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Exklusive Mitglieder-Community\",\"price\":\"20\",\"discountedPrice\":\"0\",\"id\":\"\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Haarpflege-Produkt-Analyzer\",\"price\":\"5\",\"discountedPrice\":\"0\",\"id\":\"\"}')),
    PersonalPlanStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Teilnahme-Zertifikat\",\"id\":\"\"}'))
  ];
  List<PersonalPlanStruct> get personalPlan => _personalPlan;
  set personalPlan(List<PersonalPlanStruct> value) {
    _personalPlan = value;
  }

  void addToPersonalPlan(PersonalPlanStruct value) {
    personalPlan.add(value);
  }

  void removeFromPersonalPlan(PersonalPlanStruct value) {
    personalPlan.remove(value);
  }

  void removeAtIndexFromPersonalPlan(int index) {
    personalPlan.removeAt(index);
  }

  void updatePersonalPlanAtIndex(
    int index,
    PersonalPlanStruct Function(PersonalPlanStruct) updateFn,
  ) {
    personalPlan[index] = updateFn(_personalPlan[index]);
  }

  void insertAtIndexInPersonalPlan(int index, PersonalPlanStruct value) {
    personalPlan.insert(index, value);
  }

  List<AnswerStruct> _hairGoal = [
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ich will meinen Haarausfall stoppen\",\"image\":\"https://assets.hairqare.co/mid-hairloss-graphic.webp\",\"id\":\"goal_hairloss\",\"type\":\"hairGoal\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ich will längeres, schöneres Haar\",\"image\":\"https://assets.hairqare.co/mid-hair-graphic.webp\",\"id\":\"goal_betterhair\",\"type\":\"hairGoal\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ich will beides\",\"image\":\"https://picsum.photos/seed/682/600\",\"id\":\"goal_both\",\"type\":\"hairGoal\"}'))
  ];
  List<AnswerStruct> get hairGoal => _hairGoal;
  set hairGoal(List<AnswerStruct> value) {
    _hairGoal = value;
  }

  void addToHairGoal(AnswerStruct value) {
    hairGoal.add(value);
  }

  void removeFromHairGoal(AnswerStruct value) {
    hairGoal.remove(value);
  }

  void removeAtIndexFromHairGoal(int index) {
    hairGoal.removeAt(index);
  }

  void updateHairGoalAtIndex(
    int index,
    AnswerStruct Function(AnswerStruct) updateFn,
  ) {
    hairGoal[index] = updateFn(_hairGoal[index]);
  }

  void insertAtIndexInHairGoal(int index, AnswerStruct value) {
    hairGoal.insert(index, value);
  }

  List<ImageAnswerStruct> _hairType = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Straight%20Hair%20.webp\",\"answer\":\"Glatt\",\"id\":\"hairType_straight\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Wavy%20Hair.webp\",\"answer\":\"Wellig\",\"id\":\"hairType_wavy\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Curly%20Hair.webp\",\"answer\":\"Lockig\",\"id\":\"hairType_curly\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Coily%20Hair.webp\",\"answer\":\"Kraus\",\"id\":\"hairType_coily\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q1-Not%20Sure.webp\",\"answer\":\"Weiß ich nicht\",\"id\":\"hairType_unknown\",\"type\":\"hairType\"}'))
  ];
  List<ImageAnswerStruct> get hairType => _hairType;
  set hairType(List<ImageAnswerStruct> value) {
    _hairType = value;
  }

  void addToHairType(ImageAnswerStruct value) {
    hairType.add(value);
  }

  void removeFromHairType(ImageAnswerStruct value) {
    hairType.remove(value);
  }

  void removeAtIndexFromHairType(int index) {
    hairType.removeAt(index);
  }

  void updateHairTypeAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    hairType[index] = updateFn(_hairType[index]);
  }

  void insertAtIndexInHairType(int index, ImageAnswerStruct value) {
    hairType.insert(index, value);
  }

  List<ImageAnswerStruct> _age = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Age%2018-29.webp\",\"answer\":\"18 - 29\",\"id\":\"age_18to29\",\"type\":\"age\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Age%2030-39.webp\",\"answer\":\"30 - 39\",\"id\":\"age_30to39\",\"type\":\"age\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Age%2040-49.webp\",\"answer\":\"40 - 49\",\"id\":\"age_40to49\",\"type\":\"age\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Age%2050%2B.webp\",\"answer\":\"50 +\",\"id\":\"age_50+\",\"type\":\"age\"}'))
  ];
  List<ImageAnswerStruct> get age => _age;
  set age(List<ImageAnswerStruct> value) {
    _age = value;
  }

  void addToAge(ImageAnswerStruct value) {
    age.add(value);
  }

  void removeFromAge(ImageAnswerStruct value) {
    age.remove(value);
  }

  void removeAtIndexFromAge(int index) {
    age.removeAt(index);
  }

  void updateAgeAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    age[index] = updateFn(_age[index]);
  }

  void insertAtIndexInAge(int index, ImageAnswerStruct value) {
    age.insert(index, value);
  }

  List<AnswerStruct> _knowledgeState = [
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"🙌 Ja, aber ich brauche mehr Unterstützung\",\"image\":\"\",\"id\":\"knowledge_yes\",\"type\":\"knowledgeState\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😢 Nein und ich bin es leid zu suchen\",\"image\":\"\",\"id\":\"knowledge_no\",\"type\":\"knowledgeState\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😥 Nicht sicher, alleine ist es kompliziert\",\"image\":\"\",\"id\":\"knowledge_notsure\",\"type\":\"knowledgeState\"}'))
  ];
  List<AnswerStruct> get knowledgeState => _knowledgeState;
  set knowledgeState(List<AnswerStruct> value) {
    _knowledgeState = value;
  }

  void addToKnowledgeState(AnswerStruct value) {
    knowledgeState.add(value);
  }

  void removeFromKnowledgeState(AnswerStruct value) {
    knowledgeState.remove(value);
  }

  void removeAtIndexFromKnowledgeState(int index) {
    knowledgeState.removeAt(index);
  }

  void updateKnowledgeStateAtIndex(
    int index,
    AnswerStruct Function(AnswerStruct) updateFn,
  ) {
    knowledgeState[index] = updateFn(_knowledgeState[index]);
  }

  void insertAtIndexInKnowledgeState(int index, AnswerStruct value) {
    knowledgeState.insert(index, value);
  }

  List<ImageAnswerStruct> _hairqareKnowledge = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/emoji-1.webp\",\"answer\":\"Höre zum ersten Mal davon\",\"id\":\"hairqare_unknown\",\"type\":\"hairqare\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/emoji-3.webp\",\"answer\":\"Ich weiß ein paar Dinge\",\"id\":\"hairqare_notunknown\",\"type\":\"hairqare\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/emoji-2.webp\",\"answer\":\"Ja, ich weiß alles darüber\",\"id\":\"hairqare_familiar\",\"type\":\"hairqare\"}'))
  ];
  List<ImageAnswerStruct> get hairqareKnowledge => _hairqareKnowledge;
  set hairqareKnowledge(List<ImageAnswerStruct> value) {
    _hairqareKnowledge = value;
  }

  void addToHairqareKnowledge(ImageAnswerStruct value) {
    hairqareKnowledge.add(value);
  }

  void removeFromHairqareKnowledge(ImageAnswerStruct value) {
    hairqareKnowledge.remove(value);
  }

  void removeAtIndexFromHairqareKnowledge(int index) {
    hairqareKnowledge.removeAt(index);
  }

  void updateHairqareKnowledgeAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    hairqareKnowledge[index] = updateFn(_hairqareKnowledge[index]);
  }

  void insertAtIndexInHairqareKnowledge(int index, ImageAnswerStruct value) {
    hairqareKnowledge.insert(index, value);
  }

  List<AnswerWithAdditionalInfoStruct> _mindsetState = [
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ja, definitiv\",\"image\":\"https://assets.hairqare.co/Natural.webp\",\"AnswerTitle\":\"Du hast absolut recht!\",\"AnswerDescription\":\"Ernährung, Stress, Umwelt und innere Gesundheit - alles beeinflusst deine Haare. Unser ganzheitlicher Ansatz kümmert sich um ALLE diese Faktoren für wirklich transformative Ergebnisse.\",\"id\":\"mindset_aware\",\"type\":\"mindsetState\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Vielleicht, ich bin mir nicht sicher\",\"image\":\"https://assets.hairqare.co/None.webp\",\"AnswerTitle\":\"Du bist auf dem richtigen Weg!\",\"AnswerDescription\":\"Ernährung, Stress, Umwelt und innere Gesundheit - alles beeinflusst deine Haare. Unser ganzheitlicher Ansatz kümmert sich um ALLE diese Faktoren für wirklich transformative Ergebnisse.\",\"id\":\"mindset_unsure\",\"type\":\"mindsetState\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Das habe ich noch nie in Betracht gezogen\",\"image\":\"https://assets.hairqare.co/Occasional.webp\",\"AnswerTitle\":\"Du wirst überrascht sein!\",\"AnswerDescription\":\"Ernährung, Stress, Umwelt und innere Gesundheit - alles beeinflusst deine Haare. Unser ganzheitlicher Ansatz kümmert sich um ALLE diese Faktoren für wirklich transformative Ergebnisse.\",\"id\":\"mindset_unaware\",\"type\":\"mindsetState\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Nein, ich brauche nur das richtige Produkt\",\"image\":\"https://assets.hairqare.co/Basic%20care.webp\",\"AnswerTitle\":\"Das ist ein häufiges Missverständnis\",\"AnswerDescription\":\"Die meisten Frauen konzentrieren sich nur auf äußere Behandlungen und verpassen 50% dessen, was die Haargesundheit bestimmt. Unser Ansatz ändert das, indem wir sowohl innere als auch äußere Faktoren für eine komplette Haartransformation angehen.\",\"id\":\"mindset_oblivious\",\"type\":\"mindsetState\"}'))
  ];
  List<AnswerWithAdditionalInfoStruct> get mindsetState => _mindsetState;
  set mindsetState(List<AnswerWithAdditionalInfoStruct> value) {
    _mindsetState = value;
  }

  void addToMindsetState(AnswerWithAdditionalInfoStruct value) {
    mindsetState.add(value);
  }

  void removeFromMindsetState(AnswerWithAdditionalInfoStruct value) {
    mindsetState.remove(value);
  }

  void removeAtIndexFromMindsetState(int index) {
    mindsetState.removeAt(index);
  }

  void updateMindsetStateAtIndex(
    int index,
    AnswerWithAdditionalInfoStruct Function(AnswerWithAdditionalInfoStruct)
        updateFn,
  ) {
    mindsetState[index] = updateFn(_mindsetState[index]);
  }

  void insertAtIndexInMindsetState(
      int index, AnswerWithAdditionalInfoStruct value) {
    mindsetState.insert(index, value);
  }

  List<ImageAnswerStruct> _diet = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Mostly%20unhealthy%20diet.webp\",\"answer\":\"Fast Food / Verarbeitete Lebensmittel\",\"id\":\"diet_processed\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Healthy%20and%20balanced%20diet.webp\",\"answer\":\"Ausgewogen / Vollwertkost\",\"id\":\"diet_balanced\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Professional%20planned%20diet.webp\",\"answer\":\"Individuelles Ernährungsprotokoll\",\"id\":\"diet_custom\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Vegan-vegetarian%20diet.webp\",\"answer\":\"Vegan / vegetarisch\",\"id\":\"diet_vegan\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/None.webp\",\"answer\":\"Etwas anderes\",\"id\":\"diet_other\",\"type\":\"diet\"}'))
  ];
  List<ImageAnswerStruct> get diet => _diet;
  set diet(List<ImageAnswerStruct> value) {
    _diet = value;
  }

  void addToDiet(ImageAnswerStruct value) {
    diet.add(value);
  }

  void removeFromDiet(ImageAnswerStruct value) {
    diet.remove(value);
  }

  void removeAtIndexFromDiet(int index) {
    diet.removeAt(index);
  }

  void updateDietAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    diet[index] = updateFn(_diet[index]);
  }

  void insertAtIndexInDiet(int index, ImageAnswerStruct value) {
    diet.insert(index, value);
  }

  List<AnswerWithAdditionalInfoStruct> _shampooSpending = [
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Weniger als 10€\",\"image\":\"https://assets.hairqare.co/Less%20than%20%2410.webp\",\"AnswerTitle\":\"Super 🤩 du achtest auf dein Budget!\",\"AnswerDescription\":\"Du kannst tatsächlich tolle Ergebnisse erzielen, ohne mehr auszugeben als jetzt (oder sogar weniger), während du schädliche Produkte vermeidest, die heimlich deine Haare ruinieren. Du brauchst nur die richtige Routine für deine einzigartige Situation.\",\"id\":\"spend_under10\",\"type\":\"shampooSpending\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"10€ - 20€\",\"image\":\"https://assets.hairqare.co/%2410%20-%20%2420.webp\",\"AnswerTitle\":\"Großartig 🙌 du schätzt deine Haare!\",\"AnswerDescription\":\"Du gibst bewusst Geld aus, zahlst aber wahrscheinlich immer noch für Marketing statt für Ergebnisse. Mit der richtigen Routine könntest du wirklich transformative Ergebnisse erzielen, die auf deine einzigartigen Bedürfnisse zugeschnitten sind, ohne mehr auszugeben.\",\"id\":\"spend_10to20\",\"type\":\"shampooSpending\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"20€ - 50€\",\"image\":\"https://assets.hairqare.co/%2420-%2450.webp\",\"AnswerTitle\":\"Dir sind deine Haare eindeutig wichtig 💜\",\"AnswerDescription\":\"Wusstest du, dass bei Premium-Haarpflege bis zu 90% deines Geldes für Verpackung und Marketing draufgeht, nicht für hochwertige Inhaltsstoffe? Mit der richtigen Routine kannst du tatsächlich die Premium-Ergebnisse bekommen, die du suchst, ohne den hohen Preis.\",\"id\":\"spend_20to50\",\"type\":\"shampooSpending\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Mehr als 50€\",\"image\":\"https://assets.hairqare.co/More%20than%20%2450.webp\",\"AnswerTitle\":\"Deine Haare verdienen das Beste ✨\",\"AnswerDescription\":\"Wusstest du, dass Premium-Haarpflege oft dieselben Inhaltsstoffe verwendet wie günstige Optionen? Mit der richtigen personalisierten Routine kannst du tatsächlich die Ergebnisse erzielen, die diese Luxusmarken nur versprechen.\",\"id\":\"spend_over50\",\"type\":\"shampooSpending\"}'))
  ];
  List<AnswerWithAdditionalInfoStruct> get shampooSpending => _shampooSpending;
  set shampooSpending(List<AnswerWithAdditionalInfoStruct> value) {
    _shampooSpending = value;
  }

  void addToShampooSpending(AnswerWithAdditionalInfoStruct value) {
    shampooSpending.add(value);
  }

  void removeFromShampooSpending(AnswerWithAdditionalInfoStruct value) {
    shampooSpending.remove(value);
  }

  void removeAtIndexFromShampooSpending(int index) {
    shampooSpending.removeAt(index);
  }

  void updateShampooSpendingAtIndex(
    int index,
    AnswerWithAdditionalInfoStruct Function(AnswerWithAdditionalInfoStruct)
        updateFn,
  ) {
    shampooSpending[index] = updateFn(_shampooSpending[index]);
  }

  void insertAtIndexInShampooSpending(
      int index, AnswerWithAdditionalInfoStruct value) {
    shampooSpending.insert(index, value);
  }

  List<MultiChoiceWithImagesCheckBoxStruct> _hairMyth = [
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Rosemary%20Oil.webp\",\"title\":\"Rosmarinöl reduziert Haarausfall\",\"checklBox\":\"false\",\"Id\":\"myth_rosemary\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Coconut%20Oil.webp\",\"title\":\"Kokosöl ist das beste für die Haare\",\"checklBox\":\"false\",\"Id\":\"myth_coconut\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Rice%20Water.webp\",\"title\":\"Reiswasser lässt die Haare schneller wachsen\",\"checklBox\":\"false\",\"Id\":\"myth_ricewater\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Natural.webp\",\"title\":\"Natürliche/biologische Produkte sind besser\",\"checklBox\":\"false\",\"Id\":\"myth_organic\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Not%20Washing.webp\",\"title\":\"Die Haare nicht zu waschen ist gut für die Kopfhaut\",\"checklBox\":\"false\",\"Id\":\"myth_nopoo\",\"type\":\"hairMyth\"}'))
  ];
  List<MultiChoiceWithImagesCheckBoxStruct> get hairMyth => _hairMyth;
  set hairMyth(List<MultiChoiceWithImagesCheckBoxStruct> value) {
    _hairMyth = value;
  }

  void addToHairMyth(MultiChoiceWithImagesCheckBoxStruct value) {
    hairMyth.add(value);
  }

  void removeFromHairMyth(MultiChoiceWithImagesCheckBoxStruct value) {
    hairMyth.remove(value);
  }

  void removeAtIndexFromHairMyth(int index) {
    hairMyth.removeAt(index);
  }

  void updateHairMythAtIndex(
    int index,
    MultiChoiceWithImagesCheckBoxStruct Function(
            MultiChoiceWithImagesCheckBoxStruct)
        updateFn,
  ) {
    hairMyth[index] = updateFn(_hairMyth[index]);
  }

  void insertAtIndexInHairMyth(
      int index, MultiChoiceWithImagesCheckBoxStruct value) {
    hairMyth.insert(index, value);
  }

  List<MultiChoiceWithImagesCheckBoxStruct> _hairDamageActivity = [
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/heat.webp\",\"title\":\"Hitze-Styling\",\"checklBox\":\"false\",\"Id\":\"damageAction_heat\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/dye.webp\",\"title\":\"Bleichen / Haarfarbe\",\"checklBox\":\"false\",\"Id\":\"damageAction_dye\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/sun.webp\",\"title\":\"Sonneneinstrahlung\",\"checklBox\":\"false\",\"Id\":\"damageAction_sun\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/swim.webp\",\"title\":\"Häufiges Schwimmen\",\"checklBox\":\"false\",\"Id\":\"damageAction_swimming\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/hairstyle.webp\",\"title\":\"Straffe Frisuren (Zöpfe, Dutt, Pferdeschwanz...)\",\"checklBox\":\"false\",\"Id\":\"damageAction_hairstyles\",\"type\":\"hairDamageActivity\"}'))
  ];
  List<MultiChoiceWithImagesCheckBoxStruct> get hairDamageActivity =>
      _hairDamageActivity;
  set hairDamageActivity(List<MultiChoiceWithImagesCheckBoxStruct> value) {
    _hairDamageActivity = value;
  }

  void addToHairDamageActivity(MultiChoiceWithImagesCheckBoxStruct value) {
    hairDamageActivity.add(value);
  }

  void removeFromHairDamageActivity(MultiChoiceWithImagesCheckBoxStruct value) {
    hairDamageActivity.remove(value);
  }

  void removeAtIndexFromHairDamageActivity(int index) {
    hairDamageActivity.removeAt(index);
  }

  void updateHairDamageActivityAtIndex(
    int index,
    MultiChoiceWithImagesCheckBoxStruct Function(
            MultiChoiceWithImagesCheckBoxStruct)
        updateFn,
  ) {
    hairDamageActivity[index] = updateFn(_hairDamageActivity[index]);
  }

  void insertAtIndexInHairDamageActivity(
      int index, MultiChoiceWithImagesCheckBoxStruct value) {
    hairDamageActivity.insert(index, value);
  }

  List<AnswerStruct> _professionalReferral = [
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ja\",\"image\":\"\",\"id\":\"professional_yes\",\"type\":\"professionalReferral\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Nein\",\"image\":\"\",\"id\":\"professional_no\",\"type\":\"professionalReferral\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Ich bin ein Profi\",\"image\":\"\",\"id\":\"professional_self\",\"type\":\"professionalReferral\"}'))
  ];
  List<AnswerStruct> get professionalReferral => _professionalReferral;
  set professionalReferral(List<AnswerStruct> value) {
    _professionalReferral = value;
  }

  void addToProfessionalReferral(AnswerStruct value) {
    professionalReferral.add(value);
  }

  void removeFromProfessionalReferral(AnswerStruct value) {
    professionalReferral.remove(value);
  }

  void removeAtIndexFromProfessionalReferral(int index) {
    professionalReferral.removeAt(index);
  }

  void updateProfessionalReferralAtIndex(
    int index,
    AnswerStruct Function(AnswerStruct) updateFn,
  ) {
    professionalReferral[index] = updateFn(_professionalReferral[index]);
  }

  void insertAtIndexInProfessionalReferral(int index, AnswerStruct value) {
    professionalReferral.insert(index, value);
  }

  /// The users quiz answer profile
  ProfileStruct _quizProfile = ProfileStruct();
  ProfileStruct get quizProfile => _quizProfile;
  set quizProfile(ProfileStruct value) {
    _quizProfile = value;
  }

  void updateQuizProfileStruct(Function(ProfileStruct) updateFn) {
    updateFn(_quizProfile);
  }

  ContactDetailsStruct _submittedContactDetails = ContactDetailsStruct();
  ContactDetailsStruct get submittedContactDetails => _submittedContactDetails;
  set submittedContactDetails(ContactDetailsStruct value) {
    _submittedContactDetails = value;
  }

  void updateSubmittedContactDetailsStruct(
      Function(ContactDetailsStruct) updateFn) {
    updateFn(_submittedContactDetails);
  }

  List<FieldMappingTableStruct> _cdpMapping = [
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"hairGoal\",\"acField\":\"48\",\"mpField\":\"Hair Goal\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"hairType\",\"acField\":\"20\",\"mpField\":\"Hair Type\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"age\",\"acField\":\"6\",\"mpField\":\"Age Cohort\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"hairConcern\",\"acField\":\"8\",\"mpField\":\"Hair Concern Type\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"knowledgeState\",\"acField\":\"50\",\"mpField\":\"Hair Current Issues\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"mindsetState\",\"acField\":\"56\",\"mpField\":\"Hairqare Knowledge\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"diet\",\"acField\":\"34\",\"mpField\":\"Diet\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"shampooSpending\",\"acField\":\"7\",\"mpField\":\"Spending\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"hairMyth\",\"acField\":\"35\",\"mpField\":\"hairMyth\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"hairDamageActivity\",\"acField\":\"51\",\"mpField\":\"hairDamageActivity\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"professionalReferral\",\"mpField\":\"professionalReferral\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"confidence\",\"acField\":\"53\",\"mpField\":\"Emotions Mirror\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"comparison\",\"acField\":\"54\",\"mpField\":\"Emotions Comparison\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"currentRoutine\",\"acField\":\"18\",\"mpField\":\"Haircare Background\"}')),
    FieldMappingTableStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"hairqare\",\"acField\":\"56\",\"mpField\":\"mindsetState\"}'))
  ];
  List<FieldMappingTableStruct> get cdpMapping => _cdpMapping;
  set cdpMapping(List<FieldMappingTableStruct> value) {
    _cdpMapping = value;
  }

  void addToCdpMapping(FieldMappingTableStruct value) {
    cdpMapping.add(value);
  }

  void removeFromCdpMapping(FieldMappingTableStruct value) {
    cdpMapping.remove(value);
  }

  void removeAtIndexFromCdpMapping(int index) {
    cdpMapping.removeAt(index);
  }

  void updateCdpMappingAtIndex(
    int index,
    FieldMappingTableStruct Function(FieldMappingTableStruct) updateFn,
  ) {
    cdpMapping[index] = updateFn(_cdpMapping[index]);
  }

  void insertAtIndexInCdpMapping(int index, FieldMappingTableStruct value) {
    cdpMapping.insert(index, value);
  }

  List<AnswerWithTitleAndDescriptionStruct> _currentRoutine = [
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🤓 Fortgeschritten\",\"description\":\"Salonbesuche, Premium-Produkte, Spezialisten, Nahrungsergänzungsmittel\",\"id\":\"routine_complex\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🫧 Grundpflege\",\"description\":\"Hauptsächlich nur Shampoo und Conditioner\",\"id\":\"routine_basic\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🤗 Gelegentliche Verwöhnung\",\"description\":\"Grundpflege und gelegentliche Haarmasken\",\"id\":\"routine_intermediete\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🌿 Natürliche Heilmittel\",\"description\":\"Hauptsächlich Öle, Kräuter oder DIY-Behandlungen\",\"id\":\"routine_natural\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"😌 Nichts davon\",\"description\":\"Ich folge einer anderen Haarpflege-Routine\",\"id\":\"routine_other\",\"type\":\"currentRoutine\"}'))
  ];
  List<AnswerWithTitleAndDescriptionStruct> get currentRoutine =>
      _currentRoutine;
  set currentRoutine(List<AnswerWithTitleAndDescriptionStruct> value) {
    _currentRoutine = value;
  }

  void addToCurrentRoutine(AnswerWithTitleAndDescriptionStruct value) {
    currentRoutine.add(value);
  }

  void removeFromCurrentRoutine(AnswerWithTitleAndDescriptionStruct value) {
    currentRoutine.remove(value);
  }

  void removeAtIndexFromCurrentRoutine(int index) {
    currentRoutine.removeAt(index);
  }

  void updateCurrentRoutineAtIndex(
    int index,
    AnswerWithTitleAndDescriptionStruct Function(
            AnswerWithTitleAndDescriptionStruct)
        updateFn,
  ) {
    currentRoutine[index] = updateFn(_currentRoutine[index]);
  }

  void insertAtIndexInCurrentRoutine(
      int index, AnswerWithTitleAndDescriptionStruct value) {
    currentRoutine.insert(index, value);
  }

  List<TestimonialsStruct> _testimonialMapping = [
    TestimonialsStruct.fromSerializableMap(jsonDecode(
        '{\"questionId\":\"mindsetState\",\"answerId\":\"any\",\"link\":\"https://assets.hairqare.co/Pitch%202%20Lindsey%20Review.webp\"}'))
  ];
  List<TestimonialsStruct> get testimonialMapping => _testimonialMapping;
  set testimonialMapping(List<TestimonialsStruct> value) {
    _testimonialMapping = value;
  }

  void addToTestimonialMapping(TestimonialsStruct value) {
    testimonialMapping.add(value);
  }

  void removeFromTestimonialMapping(TestimonialsStruct value) {
    testimonialMapping.remove(value);
  }

  void removeAtIndexFromTestimonialMapping(int index) {
    testimonialMapping.removeAt(index);
  }

  void updateTestimonialMappingAtIndex(
    int index,
    TestimonialsStruct Function(TestimonialsStruct) updateFn,
  ) {
    testimonialMapping[index] = updateFn(_testimonialMapping[index]);
  }

  void insertAtIndexInTestimonialMapping(int index, TestimonialsStruct value) {
    testimonialMapping.insert(index, value);
  }

  List<String> _mindsetStateTestimonials = [
    'https://assets.hairqare.co/Pitch%202%20Lindsey%20Review.webp',
    'https://assets.hairqare.co/Pitch%202%20beingdani%20Review.webp',
    'https://assets.hairqare.co/Pitch%202%20Melodie%20Review.webp',
    'https://assets.hairqare.co/Pitch%202%20Charlie%20Green%20Review.webp',
    'https://assets.hairqare.co/Pitch%202%20Larissa%20Review.webp'
  ];
  List<String> get mindsetStateTestimonials => _mindsetStateTestimonials;
  set mindsetStateTestimonials(List<String> value) {
    _mindsetStateTestimonials = value;
  }

  void addToMindsetStateTestimonials(String value) {
    mindsetStateTestimonials.add(value);
  }

  void removeFromMindsetStateTestimonials(String value) {
    mindsetStateTestimonials.remove(value);
  }

  void removeAtIndexFromMindsetStateTestimonials(int index) {
    mindsetStateTestimonials.removeAt(index);
  }

  void updateMindsetStateTestimonialsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    mindsetStateTestimonials[index] =
        updateFn(_mindsetStateTestimonials[index]);
  }

  void insertAtIndexInMindsetStateTestimonials(int index, String value) {
    mindsetStateTestimonials.insert(index, value);
  }

  List<String> _damagePracticeTestimonials = [
    'https://assets.hairqare.co/Hair%20loss%20Testimonial%203.webp',
    'https://assets.hairqare.co/PITCH%203%20Testimonial%202.webp',
    'https://assets.hairqare.co/Hair%20loss%20Testimonial%204.webp'
  ];
  List<String> get damagePracticeTestimonials => _damagePracticeTestimonials;
  set damagePracticeTestimonials(List<String> value) {
    _damagePracticeTestimonials = value;
  }

  void addToDamagePracticeTestimonials(String value) {
    damagePracticeTestimonials.add(value);
  }

  void removeFromDamagePracticeTestimonials(String value) {
    damagePracticeTestimonials.remove(value);
  }

  void removeAtIndexFromDamagePracticeTestimonials(int index) {
    damagePracticeTestimonials.removeAt(index);
  }

  void updateDamagePracticeTestimonialsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    damagePracticeTestimonials[index] =
        updateFn(_damagePracticeTestimonials[index]);
  }

  void insertAtIndexInDamagePracticeTestimonials(int index, String value) {
    damagePracticeTestimonials.insert(index, value);
  }

  bool _showDlfBanner = false;
  bool get showDlfBanner => _showDlfBanner;
  set showDlfBanner(bool value) {
    _showDlfBanner = value;
  }

  int _timerSecElapsed = 1800000;
  int get timerSecElapsed => _timerSecElapsed;
  set timerSecElapsed(int value) {
    _timerSecElapsed = value;
  }

  bool _showResultPageredirectLoader = false;
  bool get showResultPageredirectLoader => _showResultPageredirectLoader;
  set showResultPageredirectLoader(bool value) {
    _showResultPageredirectLoader = value;
  }
}
