import '/dashboard/dashboard/dashboard_widget.dart';
import '/dashboard/final_pitch/final_pitch_widget.dart';
import '/email_template/login_component/login_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/footer/footer_button/footer_button_widget.dart';
import '/header/header_with_progress_bar/header_with_progress_bar_widget.dart';
import '/loading_template/loading_screen_before_result/loading_screen_before_result_widget.dart';
import '/loading_template/start_loading_component/start_loading_component_widget.dart';
import '/pitch_body_templates/pitch_body_detailed_text_images/pitch_body_detailed_text_images_widget.dart';
import '/pitch_body_templates/pitch_body_result_label_pitch/pitch_body_result_label_pitch_widget.dart';
import '/pitch_body_templates/pitch_body_simple_text_images_body/pitch_body_simple_text_images_body_widget.dart';
import '/templates/image_background_ques_body/image_background_ques_body_widget.dart';
import '/templates/image_background_ques_body_v3/image_background_ques_body_v3_widget.dart';
import '/templates/multi_choice_with_image_question_check_box/multi_choice_with_image_question_check_box_widget.dart';
import '/templates/question_answer/question_answer_widget.dart';
import '/templates/question_answer_additionl_info/question_answer_additionl_info_widget.dart';
import '/templates/rating_question_options/rating_question_options_widget.dart';
import '/templates/single_choice_question_large_image/single_choice_question_large_image_widget.dart';
import '/templates/single_choice_question_smalllmage/single_choice_question_smalllmage_widget.dart';
import '/templates/titles_and_description_ans_body/titles_and_description_ans_body_widget.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - isFacebookWebView] action in HomePage widget.
  bool? isWebview;
  // Model for HeaderWithProgressBar component.
  late HeaderWithProgressBarModel headerWithProgressBarModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for StartGoalImageBackground_QuesBody.
  late ImageBackgroundQuesBodyModel startGoalImageBackgroundQuesBodyModel;
  // Model for Type-SingleChoiceQuestion_LargeImage.
  late SingleChoiceQuestionLargeImageModel
      typeSingleChoiceQuestionLargeImageModel;
  // Model for AgeSingleChoiceQuestion_Smalllmage.
  late SingleChoiceQuestionSmalllmageModel
      ageSingleChoiceQuestionSmalllmageModel;
  // Model for Concern-SingleChoiceQuestion_Smalllmage.
  late SingleChoiceQuestionSmalllmageModel
      concernSingleChoiceQuestionSmalllmageModel;
  // Model for Duration-Question_Answer.
  late QuestionAnswerModel durationQuestionAnswerModel;
  // Model for RoutineTitlesAndDescription_AnsBody.
  late TitlesAndDescriptionAnsBodyModel routineTitlesAndDescriptionAnsBodyModel;
  // Model for PitchHFD1PitchBody_textImagesBodyCopy.
  late PitchBodySimpleTextImagesBodyModel
      pitchHFD1PitchBodyTextImagesBodyCopyModel;
  // Model for HairqareMethodSingleChoiceQuestion_Smalllmage.
  late SingleChoiceQuestionSmalllmageModel
      hairqareMethodSingleChoiceQuestionSmalllmageModel;
  // Model for PitchBody_textImagesHolistic.
  late PitchBodyDetailedTextImagesModel pitchBodyTextImagesHolisticModel;
  // Model for Diet-SingleChoiceQuestion_Smalllmage.
  late SingleChoiceQuestionSmalllmageModel
      dietSingleChoiceQuestionSmalllmageModel;
  // Model for Spend-Question_Answer_Additionl_info.
  late QuestionAnswerAdditionlInfoModel spendQuestionAnswerAdditionlInfoModel;
  // Model for Myths-MultiChoiceWithImageQuestion_CheckBox.
  late MultiChoiceWithImageQuestionCheckBoxModel
      mythsMultiChoiceWithImageQuestionCheckBoxModel;
  // Model for DamagePractice-MultiChoiceWithImageQuestion_CheckBox.
  late MultiChoiceWithImageQuestionCheckBoxModel
      damagePracticeMultiChoiceWithImageQuestionCheckBoxModel;
  // Model for problemDescriptionQuestion_Smalllmage.
  late SingleChoiceQuestionSmalllmageModel
      problemDescriptionQuestionSmalllmageModel;
  // Model for HFDtypePitchBody_resultLabelPitch.
  late PitchBodyResultLabelPitchModel hFDtypePitchBodyResultLabelPitchModel;
  // Model for OriginProblem-MultiChoiceWithImageQuestion_CheckBox.
  late MultiChoiceWithImageQuestionCheckBoxModel
      originProblemMultiChoiceWithImageQuestionCheckBoxModel;
  // Model for Mirror-RatingQuestion_Options.
  late RatingQuestionOptionsModel mirrorRatingQuestionOptionsModel;
  // Model for Compare-RatingQuestion_Options.
  late RatingQuestionOptionsModel compareRatingQuestionOptionsModel;
  // Model for Professional-Question_Answer.
  late QuestionAnswerModel professionalQuestionAnswerModel;
  // Model for LoadingScreen_beforeResult component.
  late LoadingScreenBeforeResultModel loadingScreenBeforeResultModel;
  // Model for LoginComponent component.
  late LoginComponentModel loginComponentModel;
  // Stores action output result for [Custom Action - convertToTitleCase] action in LoginComponent widget.
  String? capitalisedName;
  // Model for Dashboard component.
  late DashboardModel dashboardModel;
  // Model for Final_Pitch component.
  late FinalPitchModel finalPitchModel;
  // Model for StartLoadingComponent component.
  late StartLoadingComponentModel startLoadingComponentModel;
  // Model for Holistic-Question_Answer_Additionl_info.
  late QuestionAnswerAdditionlInfoModel
      holisticQuestionAnswerAdditionlInfoModel;
  // Model for Goal-ImageBackground_QuesBodyV3.
  late ImageBackgroundQuesBodyV3Model goalImageBackgroundQuesBodyV3Model;
  // Model for FooterButton component.
  late FooterButtonModel footerButtonModel;

  @override
  void initState(BuildContext context) {
    headerWithProgressBarModel =
        createModel(context, () => HeaderWithProgressBarModel());
    startGoalImageBackgroundQuesBodyModel =
        createModel(context, () => ImageBackgroundQuesBodyModel());
    typeSingleChoiceQuestionLargeImageModel =
        createModel(context, () => SingleChoiceQuestionLargeImageModel());
    ageSingleChoiceQuestionSmalllmageModel =
        createModel(context, () => SingleChoiceQuestionSmalllmageModel());
    concernSingleChoiceQuestionSmalllmageModel =
        createModel(context, () => SingleChoiceQuestionSmalllmageModel());
    durationQuestionAnswerModel =
        createModel(context, () => QuestionAnswerModel());
    routineTitlesAndDescriptionAnsBodyModel =
        createModel(context, () => TitlesAndDescriptionAnsBodyModel());
    pitchHFD1PitchBodyTextImagesBodyCopyModel =
        createModel(context, () => PitchBodySimpleTextImagesBodyModel());
    hairqareMethodSingleChoiceQuestionSmalllmageModel =
        createModel(context, () => SingleChoiceQuestionSmalllmageModel());
    pitchBodyTextImagesHolisticModel =
        createModel(context, () => PitchBodyDetailedTextImagesModel());
    dietSingleChoiceQuestionSmalllmageModel =
        createModel(context, () => SingleChoiceQuestionSmalllmageModel());
    spendQuestionAnswerAdditionlInfoModel =
        createModel(context, () => QuestionAnswerAdditionlInfoModel());
    mythsMultiChoiceWithImageQuestionCheckBoxModel =
        createModel(context, () => MultiChoiceWithImageQuestionCheckBoxModel());
    damagePracticeMultiChoiceWithImageQuestionCheckBoxModel =
        createModel(context, () => MultiChoiceWithImageQuestionCheckBoxModel());
    problemDescriptionQuestionSmalllmageModel =
        createModel(context, () => SingleChoiceQuestionSmalllmageModel());
    hFDtypePitchBodyResultLabelPitchModel =
        createModel(context, () => PitchBodyResultLabelPitchModel());
    originProblemMultiChoiceWithImageQuestionCheckBoxModel =
        createModel(context, () => MultiChoiceWithImageQuestionCheckBoxModel());
    mirrorRatingQuestionOptionsModel =
        createModel(context, () => RatingQuestionOptionsModel());
    compareRatingQuestionOptionsModel =
        createModel(context, () => RatingQuestionOptionsModel());
    professionalQuestionAnswerModel =
        createModel(context, () => QuestionAnswerModel());
    loadingScreenBeforeResultModel =
        createModel(context, () => LoadingScreenBeforeResultModel());
    loginComponentModel = createModel(context, () => LoginComponentModel());
    dashboardModel = createModel(context, () => DashboardModel());
    finalPitchModel = createModel(context, () => FinalPitchModel());
    startLoadingComponentModel =
        createModel(context, () => StartLoadingComponentModel());
    holisticQuestionAnswerAdditionlInfoModel =
        createModel(context, () => QuestionAnswerAdditionlInfoModel());
    goalImageBackgroundQuesBodyV3Model =
        createModel(context, () => ImageBackgroundQuesBodyV3Model());
    footerButtonModel = createModel(context, () => FooterButtonModel());
  }

  @override
  void dispose() {
    headerWithProgressBarModel.dispose();
    startGoalImageBackgroundQuesBodyModel.dispose();
    typeSingleChoiceQuestionLargeImageModel.dispose();
    ageSingleChoiceQuestionSmalllmageModel.dispose();
    concernSingleChoiceQuestionSmalllmageModel.dispose();
    durationQuestionAnswerModel.dispose();
    routineTitlesAndDescriptionAnsBodyModel.dispose();
    pitchHFD1PitchBodyTextImagesBodyCopyModel.dispose();
    hairqareMethodSingleChoiceQuestionSmalllmageModel.dispose();
    pitchBodyTextImagesHolisticModel.dispose();
    dietSingleChoiceQuestionSmalllmageModel.dispose();
    spendQuestionAnswerAdditionlInfoModel.dispose();
    mythsMultiChoiceWithImageQuestionCheckBoxModel.dispose();
    damagePracticeMultiChoiceWithImageQuestionCheckBoxModel.dispose();
    problemDescriptionQuestionSmalllmageModel.dispose();
    hFDtypePitchBodyResultLabelPitchModel.dispose();
    originProblemMultiChoiceWithImageQuestionCheckBoxModel.dispose();
    mirrorRatingQuestionOptionsModel.dispose();
    compareRatingQuestionOptionsModel.dispose();
    professionalQuestionAnswerModel.dispose();
    loadingScreenBeforeResultModel.dispose();
    loginComponentModel.dispose();
    dashboardModel.dispose();
    finalPitchModel.dispose();
    startLoadingComponentModel.dispose();
    holisticQuestionAnswerAdditionlInfoModel.dispose();
    goalImageBackgroundQuesBodyV3Model.dispose();
    footerButtonModel.dispose();
  }
}
