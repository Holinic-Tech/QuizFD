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
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World'
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
    'Revisando el estado de tu cabello',
    'Analizando tu rutina',
    'Comprobando si el reto es para ti'
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
        jsonDecode('{\"title\":\"Calor\",\"checkBox\":\"false\"}')),
    MultiChoiceCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Bleaching / hair colour\",\"checkBox\":\"false\"}')),
    MultiChoiceCheckBoxStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Exposición al sol\",\"checkBox\":\"false\"}')),
    MultiChoiceCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Peinados tirantes (trenzas, moño, coleta...)\",\"checkBox\":\"false\"}'))
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
        '{\"title\":\"Sin dieta específica\",\"description\":\"I don\'t have any dietary restrictions\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Vegetariana\",\"description\":\"I abstain from meat, fish, and poultry\\nproducts\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Sin gluten\",\"description\":\"I avoid wheat, barley, rye or other grains\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Vegana\",\"description\":\"I avoid all animal-based products: meat,\\neggs, dairy, etc. Plant-based foods only\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Otra\",\"description\":\"\"}'))
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
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Answer 1\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Answer 2\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Answer 3\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301e2d7eaa36cb_62a20099979bdb2469305727_haircare-done-right%20(2).jpeg\",\"answer\":\"Answer 4\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://picsum.photos/seed/515/600\",\"answer\":\"Hello World\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://picsum.photos/seed/152/600\",\"answer\":\"Hello World\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://picsum.photos/seed/258/600\",\"answer\":\"Hello World\"}'))
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
        '{\"answer\":\"Calor\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Bleaching / hair colour\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Nadar frecuentemente\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Exposición al sol\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Peinados tirantes (trenzas, moño, coleta...)\",\"image\":\"https://cdn.pixabay.com/photo/2020/12/27/20/25/smile-5865209_1280.png\"}')),
    AnswerStruct.fromSerializableMap(
        jsonDecode('{\"answer\":\"None of the above\"}'))
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
        '{\"image\":\"https://assets.hairqare.co/Q3%20Hair%20loss.webp\",\"answer\":\"Caída o pelo más fino\",\"id\":\"concern_hairloss\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Damage%20Hair.webp\",\"answer\":\"Daño por tintes, calor o tratamientos químicos\",\"id\":\"concern_damage\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Irritation.webp\",\"answer\":\"Irritación del cuero cabelludo o caspa\",\"id\":\"concern_scalp\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20Split%20ends.webp\",\"answer\":\"Puntas abiertas, frizz y sequedad\",\"id\":\"concern_splitends\",\"type\":\"hairConcern\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q3%20other.webp\",\"answer\":\"Otros problemas variados\",\"id\":\"concern_mixed\",\"type\":\"hairConcern\"}'))
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
    '🚫 Se acabaron los ingredientes dañinos ocultos.',
    '🌱 Menos caída y nuevos pelitos baby.',
    '✅ Split ends that don\'t come back.',
    '💛 Lo mejor de la ciencia, fácil en casa.'
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
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Rosemary oil is a universal treatment\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"El aceite de coco es el mejor para el pelo\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Rice water will make your hair grow faster\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Natural and organic products are better\",\"checklBox\":\"false\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://cdn.prod.website-files.com/62cbaa353a301eb715aa33d0/62cbaa353a301ee4ebaa36ce_IMG_1173-scaled-p-500.jpeg\",\"title\":\"Hair can heal like the skin\",\"checklBox\":\"false\"}'))
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
        '{\"answer\":\"Never\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"A Balanced Mind Leads to a Healthy Life\",\"AnswerDescription\":\"Studies suggest that maintaining a stress-free lifestyle enhances overall well-being, boosts productivity, and improves mental clarity.\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Rarely\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Managing Stress Before It Manages You\",\"AnswerDescription\":\"While occasional stress is normal, addressing small stressors early can prevent them from building up.\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Often\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Understanding & Reducing Stress\",\"AnswerDescription\":\"Studies reveal that chronic stress can impact both physical and mental health.\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"All the time\",\"image\":\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYlCFrIs7OelYi4FFlx23TEc4Z_evhDZkoQ&s\",\"AnswerTitle\":\"Prioritizing Mental Well-Being\",\"AnswerDescription\":\"If stress is a constant part of life, it may be helpful to explore structured stress management strategies, such as therapy, mindfulness training, or guided relaxation techniques.\"}'))
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
        '{\"title\":\"Reto de 14 Días\",\"actualPrice\":\"300\",\"discountedPrice\":\"37\",\"perDayActualPrice\":\"300\",\"discountedPerDayPrice\":\"85\",\"isPopularPlan\":\"true\"}'))
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
        '{\"title\":\"Diario de Cuidado Capilar de 14 Días y Plantillas\",\"price\":\"29\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Taller de Champú de Lujo Casero\",\"price\":\"39\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Lista de Ingredientes Prohibidos\",\"price\":\"35\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Manual Completo de Bienestar Capilar\",\"price\":\"29\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Manual de Uso Inteligente de Siliconas y Sulfatos\",\"price\":\"29\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Experiencia de Mindfulness Capilar de 30 Días\",\"price\":\"15\",\"discountedPrice\":\"0\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Comunidad Exclusiva para Miembros\",\"price\":\"20\",\"discountedPrice\":\"0\",\"id\":\"\"}')),
    PersonalPlanStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Analizador de Productos Capilares\",\"price\":\"5\",\"discountedPrice\":\"0\",\"id\":\"\"}')),
    PersonalPlanStruct.fromSerializableMap(
        jsonDecode('{\"title\":\"Certificado de Finalización\",\"id\":\"\"}'))
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

  /// Do you know if you have follicle dysfunction
  List<AnswerStruct> _diagnosisFD = [
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Sí\",\"image\":\"https://assets.hairqare.co/mid-hairloss-graphic.webp\",\"id\":\"diagnosisFD_yes\",\"type\":\"diagnosisFD\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"No\",\"image\":\"https://assets.hairqare.co/mid-hair-graphic.webp\",\"id\":\"diagnosisFD_no\",\"type\":\"diagnosisFD\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"I don\'t know\",\"image\":\"https://picsum.photos/seed/682/600\",\"id\":\"diagnosisFD_dontknow\",\"type\":\"diagnosisFD\"}'))
  ];
  List<AnswerStruct> get diagnosisFD => _diagnosisFD;
  set diagnosisFD(List<AnswerStruct> value) {
    _diagnosisFD = value;
  }

  void addToDiagnosisFD(AnswerStruct value) {
    diagnosisFD.add(value);
  }

  void removeFromDiagnosisFD(AnswerStruct value) {
    diagnosisFD.remove(value);
  }

  void removeAtIndexFromDiagnosisFD(int index) {
    diagnosisFD.removeAt(index);
  }

  void updateDiagnosisFDAtIndex(
    int index,
    AnswerStruct Function(AnswerStruct) updateFn,
  ) {
    diagnosisFD[index] = updateFn(_diagnosisFD[index]);
  }

  void insertAtIndexInDiagnosisFD(int index, AnswerStruct value) {
    diagnosisFD.insert(index, value);
  }

  List<ImageAnswerStruct> _hairType = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Straight%20Hair%20.webp\",\"answer\":\"Liso\",\"id\":\"hairType_straight\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Wavy%20Hair.webp\",\"answer\":\"Ondulado\",\"id\":\"hairType_wavy\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Curly%20Hair.webp\",\"answer\":\"Rizado\",\"id\":\"hairType_curly\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Coily%20Hair.webp\",\"answer\":\"Afro\",\"id\":\"hairType_coily\",\"type\":\"hairType\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Q1-Not%20Sure.webp\",\"answer\":\"I don\'t know\",\"id\":\"hairType_unknown\",\"type\":\"hairType\"}'))
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
        '{\"answer\":\"🙌 Sí, pero necesito más apoyo\",\"image\":\"\",\"id\":\"knowledge_yes\",\"type\":\"knowledgeState\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😢 No and I\'m tired of searching\",\"image\":\"\",\"id\":\"knowledge_no\",\"type\":\"knowledgeState\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😥 Not sure, it\'s complicated by myself\",\"image\":\"\",\"id\":\"knowledge_notsure\",\"type\":\"knowledgeState\"}'))
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
        '{\"image\":\"https://assets.hairqare.co/emoji-1.webp\",\"answer\":\"I’m hearing about it for the first time\",\"id\":\"hairqare_unknown\",\"type\":\"hairqare\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/emoji-3.webp\",\"answer\":\"Sé algunas cosas\",\"id\":\"hairqare_notunknown\",\"type\":\"hairqare\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/emoji-2.webp\",\"answer\":\"Sí, lo sé todo sobre ello\",\"id\":\"hairqare_familiar\",\"type\":\"hairqare\"}'))
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
        '{\"answer\":\"Sí, totalmente\",\"image\":\"https://assets.hairqare.co/Natural.webp\",\"AnswerTitle\":\"You\'re absolutely right!\",\"AnswerDescription\":\"La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.\",\"id\":\"mindset_aware\",\"type\":\"mindsetState\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"Maybe, I\'m not sure\",\"image\":\"https://assets.hairqare.co/None.webp\",\"AnswerTitle\":\"You\'re on the right track!\",\"AnswerDescription\":\"La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.\",\"id\":\"mindset_unsure\",\"type\":\"mindsetState\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"I\'ve never considered that\",\"image\":\"https://assets.hairqare.co/Occasional.webp\",\"AnswerTitle\":\"You\'ll be surprised!\",\"AnswerDescription\":\"La dieta, el estrés, el ambiente y la salud interna afectan tu pelo. Nuestro enfoque holístico aborda TODOS estos factores para resultados realmente transformadores.\",\"id\":\"mindset_unaware\",\"type\":\"mindsetState\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"No, solo necesito el producto adecuado\",\"image\":\"https://assets.hairqare.co/Basic%20care.webp\",\"AnswerTitle\":\"It\'s a common misconception\",\"AnswerDescription\":\"La mayoría de las mujeres se centran solo en tratamientos externos, perdiendo el 50% de lo que determina la salud del cabello. Nuestro enfoque cambia eso abordando factores internos y externos para una transformación completa del cabello.\",\"id\":\"mindset_oblivious\",\"type\":\"mindsetState\"}'))
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
        '{\"image\":\"https://assets.hairqare.co/Mostly%20unhealthy%20diet.webp\",\"answer\":\"Comida rápida / Alimentos procesados\",\"id\":\"diet_processed\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Healthy%20and%20balanced%20diet.webp\",\"answer\":\"Equilibrada / Alimentos integrales\",\"id\":\"diet_balanced\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Professional%20planned%20diet.webp\",\"answer\":\"Protocolo nutricional personalizado\",\"id\":\"diet_custom\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Vegan-vegetarian%20diet.webp\",\"answer\":\"Vegana / vegetariana\",\"id\":\"diet_vegan\",\"type\":\"diet\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/None.webp\",\"answer\":\"Otra cosa\",\"id\":\"diet_other\",\"type\":\"diet\"}'))
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
        '{\"answer\":\"Less than \$10\",\"image\":\"https://assets.hairqare.co/Less%20than%20%2410.webp\",\"AnswerTitle\":\"Awesome 🤩 you\'re budget conscious!\",\"AnswerDescription\":\"Puedes tener resultados increíbles sin gastar más de lo que gastas ahora (o incluso menos) evitando productos dañinos que arruinan tu pelo en secreto. Solo necesitas la rutina adecuada para tu situación única.\",\"id\":\"spend_under10\",\"type\":\"shampooSpending\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"\$10 - \$20\",\"image\":\"https://assets.hairqare.co/%2410%20-%20%2420.webp\",\"AnswerTitle\":\"¡Increíble 🙌 valoras tu pelo!\",\"AnswerDescription\":\"You\'re spending thoughtfully, but likely still paying for marketing rather than results. With the right routine, you could get truly transformative results tailored to your unique needs without spending more.\",\"id\":\"spend_10to20\",\"type\":\"shampooSpending\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"\$20 - \$50\",\"image\":\"https://assets.hairqare.co/%2420-%2450.webp\",\"AnswerTitle\":\"Claramente te importa tu pelo 💜\",\"AnswerDescription\":\"Did you know, in premium haircare up to 90% of what you\'re paying goes to packaging and marketing, not quality ingredients? With the right routine, you can actually get the premium results you\'re looking for without the price tag.\",\"id\":\"spend_20to50\",\"type\":\"shampooSpending\"}')),
    AnswerWithAdditionalInfoStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"More than \$50\",\"image\":\"https://assets.hairqare.co/More%20than%20%2450.webp\",\"AnswerTitle\":\"Tu pelo merece lo mejor ✨\",\"AnswerDescription\":\"¿Sabías que los productos premium a menudo usan los mismos ingredientes que las opciones económicas? Con la rutina personalizada adecuada, puedes lograr los resultados que esas marcas de lujo solo prometen.\",\"id\":\"spend_over50\",\"type\":\"shampooSpending\"}'))
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
        '{\"image\":\"https://assets.hairqare.co/Rosemary%20Oil.webp\",\"title\":\"El aceite de romero reduce la caída\",\"checklBox\":\"false\",\"Id\":\"myth_rosemary\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Coconut%20Oil.webp\",\"title\":\"El aceite de coco es el mejor para el pelo\",\"checklBox\":\"false\",\"Id\":\"myth_coconut\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Rice%20Water.webp\",\"title\":\"El agua de arroz hace crecer el pelo más rápido\",\"checklBox\":\"false\",\"Id\":\"myth_ricewater\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Natural.webp\",\"title\":\"Los productos naturales/orgánicos son mejores\",\"checklBox\":\"false\",\"Id\":\"myth_organic\",\"type\":\"hairMyth\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/Not%20Washing.webp\",\"title\":\"No lavar el pelo es bueno para el cuero cabelludo\",\"checklBox\":\"false\",\"Id\":\"myth_nopoo\",\"type\":\"hairMyth\"}'))
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
        '{\"image\":\"https://assets.hairqare.co/heat.webp\",\"title\":\"Calor\",\"checklBox\":\"false\",\"Id\":\"damageAction_heat\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/dye.webp\",\"title\":\"Decoloración / tinte\",\"checklBox\":\"false\",\"Id\":\"damageAction_dye\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/sun.webp\",\"title\":\"Exposición al sol\",\"checklBox\":\"false\",\"Id\":\"damageAction_sun\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/swim.webp\",\"title\":\"Nadar frecuentemente\",\"checklBox\":\"false\",\"Id\":\"damageAction_swimming\",\"type\":\"hairDamageActivity\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/hairstyle.webp\",\"title\":\"Peinados tirantes (trenzas, moño, coleta...)\",\"checklBox\":\"false\",\"Id\":\"damageAction_hairstyles\",\"type\":\"hairDamageActivity\"}'))
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
        '{\"answer\":\"Sí\",\"image\":\"\",\"id\":\"professional_yes\",\"type\":\"professionalReferral\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"No\",\"image\":\"\",\"id\":\"professional_no\",\"type\":\"professionalReferral\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"I\'m a professional\",\"image\":\"\",\"id\":\"professional_self\",\"type\":\"professionalReferral\"}'))
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
        '{\"title\":\"🤓 Avanzada\",\"description\":\"Salon visits, premium products, specialists, supplements\",\"id\":\"routine_complex\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🫧 Cuidado básico\",\"description\":\"Mostly just shampoo and conditioner\",\"id\":\"routine_basic\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🤗 Mimos ocasionales\",\"description\":\"Basic care and occasional hair masks\",\"id\":\"routine_intermediete\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"🌿 Remedios naturales\",\"description\":\"Mostly oils, herbs or DIY treatments\",\"id\":\"routine_natural\",\"type\":\"currentRoutine\"}')),
    AnswerWithTitleAndDescriptionStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"😌 Ninguno de los anteriores\",\"description\":\"I follow a different haircare routine\",\"id\":\"routine_other\",\"type\":\"currentRoutine\"}'))
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

  /// For how long have you had this issue?
  List<AnswerStruct> _concernDuration = [
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😯 Less than 6 months\",\"image\":\"\",\"id\":\"concernDuration_less6month\",\"type\":\"concernDuration\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😟 6 months to 1 year\",\"image\":\"\",\"id\":\"concernDuration_6-1year\",\"type\":\"concernDuration\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😣 1-2 years\",\"image\":\"\",\"id\":\"concernDuration_1-2years\",\"type\":\"concernDuration\"}')),
    AnswerStruct.fromSerializableMap(jsonDecode(
        '{\"answer\":\"😵‍💫 2+ years\",\"image\":\"\",\"id\":\"concernDuration_2+years\",\"type\":\"concernDuration\"}'))
  ];
  List<AnswerStruct> get concernDuration => _concernDuration;
  set concernDuration(List<AnswerStruct> value) {
    _concernDuration = value;
  }

  void addToConcernDuration(AnswerStruct value) {
    concernDuration.add(value);
  }

  void removeFromConcernDuration(AnswerStruct value) {
    concernDuration.remove(value);
  }

  void removeAtIndexFromConcernDuration(int index) {
    concernDuration.removeAt(index);
  }

  void updateConcernDurationAtIndex(
    int index,
    AnswerStruct Function(AnswerStruct) updateFn,
  ) {
    concernDuration[index] = updateFn(_concernDuration[index]);
  }

  void insertAtIndexInConcernDuration(int index, AnswerStruct value) {
    concernDuration.insert(index, value);
  }

  /// How would you describe your hair problems?
  List<ImageAnswerStruct> _problemDescription = [
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/descriptionProblem_1consistent.webp\",\"answer\":\"One main issue that\'s been consistent\",\"id\":\"problemDescription_1consistent\",\"type\":\"problemDescription\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/descriptionProblem_getting%20worse.webp\",\"answer\":\"Problems that keep getting worse\",\"id\":\"problemDescription_keep-changing\",\"type\":\"problemDescription\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/descriptionProblem_come-go.webp\",\"answer\":\"Issues that come and go unpredictably\",\"id\":\"problemDescription_come&go\",\"type\":\"problemDescription\"}')),
    ImageAnswerStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/descriptionProblem_multiply.webp\",\"answer\":\"Problems that seem to multiply over time\",\"id\":\"problemDescription_multiply\",\"type\":\"problemDescription\"}'))
  ];
  List<ImageAnswerStruct> get problemDescription => _problemDescription;
  set problemDescription(List<ImageAnswerStruct> value) {
    _problemDescription = value;
  }

  void addToProblemDescription(ImageAnswerStruct value) {
    problemDescription.add(value);
  }

  void removeFromProblemDescription(ImageAnswerStruct value) {
    problemDescription.remove(value);
  }

  void removeAtIndexFromProblemDescription(int index) {
    problemDescription.removeAt(index);
  }

  void updateProblemDescriptionAtIndex(
    int index,
    ImageAnswerStruct Function(ImageAnswerStruct) updateFn,
  ) {
    problemDescription[index] = updateFn(_problemDescription[index]);
  }

  void insertAtIndexInProblemDescription(int index, ImageAnswerStruct value) {
    problemDescription.insert(index, value);
  }

  List<MultiChoiceWithImagesCheckBoxStruct> _originProblem = [
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_schedule.webp\",\"title\":\"Overwhelming schedule\",\"checklBox\":\"false\",\"Id\":\"originProblem_schedule\",\"type\":\"originProblem\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_big-changes.webp\",\"title\":\"Major life stress or changes\",\"checklBox\":\"false\",\"Id\":\"originProblem_majorstress\",\"type\":\"originProblem\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_hormones.webp\",\"title\":\"Hormonal shifts \\n(birth control, pregnancy, menopause...)\",\"checklBox\":\"false\",\"Id\":\"originProblem_hormones\",\"type\":\"originProblem\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_medicine.webp\",\"title\":\"Health issues or new medications\",\"checklBox\":\"false\",\"Id\":\"originProblem_health\",\"type\":\"originProblem\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_responsibilities.webp\",\"title\":\"Chronic stress \\nfrom juggling too many responsibilities\",\"checklBox\":\"false\",\"Id\":\"originProblem_chronic-stress\",\"type\":\"originProblem\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_weight.webp\",\"title\":\"Significant weight changes\",\"checklBox\":\"false\",\"Id\":\"originProblem_weight\",\"type\":\"originProblem\"}')),
    MultiChoiceWithImagesCheckBoxStruct.fromSerializableMap(jsonDecode(
        '{\"image\":\"https://assets.hairqare.co/originProblem_sleep.webp\",\"title\":\"Poor sleep\",\"checklBox\":\"false\",\"Id\":\"originProblem_sleep\",\"type\":\"originProblem\"}'))
  ];
  List<MultiChoiceWithImagesCheckBoxStruct> get originProblem => _originProblem;
  set originProblem(List<MultiChoiceWithImagesCheckBoxStruct> value) {
    _originProblem = value;
  }

  void addToOriginProblem(MultiChoiceWithImagesCheckBoxStruct value) {
    originProblem.add(value);
  }

  void removeFromOriginProblem(MultiChoiceWithImagesCheckBoxStruct value) {
    originProblem.remove(value);
  }

  void removeAtIndexFromOriginProblem(int index) {
    originProblem.removeAt(index);
  }

  void updateOriginProblemAtIndex(
    int index,
    MultiChoiceWithImagesCheckBoxStruct Function(
            MultiChoiceWithImagesCheckBoxStruct)
        updateFn,
  ) {
    originProblem[index] = updateFn(_originProblem[index]);
  }

  void insertAtIndexInOriginProblem(
      int index, MultiChoiceWithImagesCheckBoxStruct value) {
    originProblem.insert(index, value);
  }

  /// is true if we detected a webview browser to adjsut padding and viewport to
  bool _isWebview = false;
  bool get isWebview => _isWebview;
  set isWebview(bool value) {
    _isWebview = value;
  }
}
