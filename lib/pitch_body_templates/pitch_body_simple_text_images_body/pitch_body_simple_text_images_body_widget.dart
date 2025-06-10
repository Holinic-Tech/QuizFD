import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/footer/footer_button/footer_button_widget.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'pitch_body_simple_text_images_body_model.dart';
export 'pitch_body_simple_text_images_body_model.dart';

class PitchBodySimpleTextImagesBodyWidget extends StatefulWidget {
  const PitchBodySimpleTextImagesBodyWidget({
    super.key,
    this.image,
    this.title,
    this.description,
    required this.navigationTap,
  });

  final String? image;
  final String? title;
  final String? description;

  /// Continue button on tap
  final Future Function()? navigationTap;

  @override
  State<PitchBodySimpleTextImagesBodyWidget> createState() =>
      _PitchBodySimpleTextImagesBodyWidgetState();
}

class _PitchBodySimpleTextImagesBodyWidgetState
    extends State<PitchBodySimpleTextImagesBodyWidget> {
  late PitchBodySimpleTextImagesBodyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PitchBodySimpleTextImagesBodyModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.pitchTitle = widget.title;
      _model.pitchDescription = widget.description;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, -1.0),
      child: Container(
        height: double.infinity,
        constraints: BoxConstraints(
          maxWidth: () {
            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
              return 500.0;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
              return double.infinity;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
              return 500.0;
            } else {
              return 500.0;
            }
          }(),
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 35.0, 0.0, 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            valueOrDefault<String>(
                              () {
                                if (FFAppState()
                                    .quizProfile
                                    .qaPairs
                                    .contains(QuestionAnswerPairStruct(
                                      questionId: 'hairConcern',
                                      answerIds: ['concern_hairloss'],
                                    ))) {
                                  return 'https://assets.hairqare.co/P3%20Hair%20Loss.webp';
                                } else if (FFAppState()
                                    .quizProfile
                                    .qaPairs
                                    .contains(QuestionAnswerPairStruct(
                                      questionId: 'hairConcern',
                                      answerIds: ['concern_splitends'],
                                    ))) {
                                  return 'https://assets.hairqare.co/P5%20Split%20Ends.webp';
                                } else if (FFAppState()
                                    .quizProfile
                                    .qaPairs
                                    .contains(QuestionAnswerPairStruct(
                                      questionId: 'hairConcern',
                                      answerIds: ['concern_scalp'],
                                    ))) {
                                  return 'https://assets.hairqare.co/P2%20Dandruff.webp';
                                } else if (FFAppState()
                                    .quizProfile
                                    .qaPairs
                                    .contains(QuestionAnswerPairStruct(
                                      questionId: 'hairConcern',
                                      answerIds: ['concern_damage'],
                                    ))) {
                                  return 'https://assets.hairqare.co/P1%20Damage%20Hair.webp';
                                } else {
                                  return 'https://assets.hairqare.co/P4%20Others.webp';
                                }
                              }(),
                              'https://assets.hairqare.co/P4%20Others.webp',
                            ),
                            width: 200.0,
                            height: MediaQuery.sizeOf(context).height < 500.0
                                ? 160.0
                                : 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 35.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'u7c6uom7' /* Follicle dysfunction probabili... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            LinearPercentIndicator(
                              percent: random_data.randomDouble(0.79, 0.87),
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              lineHeight: 30.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor:
                                  FlutterFlowTheme.of(context).button,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              center: Text(
                                FFLocalizations.of(context).getText(
                                  'qgq1r05e' /* High  */,
                                ),
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                              ),
                              barRadius: Radius.circular(100.0),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            valueOrDefault<double>(
                              MediaQuery.sizeOf(context).height < 500.0
                                  ? 80.0
                                  : 0.0,
                              0.0,
                            )),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: () {
                                  if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_complex'],
                                      ))) {
                                    return 'With your level of effort and expertise, your hair should be at the top of its game. ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_basic'],
                                      ))) {
                                    return 'When follicles are functioning properly, basic care should be MORE than enough to get beautiful hair. ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['concern_scalp'],
                                      ))) {
                                    return 'When follicles are functioning properly, simple care & occasional pampering should be MORE than enough to get beautiful hair. ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_natural'],
                                      ))) {
                                    return 'The right natural ingredients are incredibly nourishing; they should be giving your hair everything it needs. ';
                                  } else {
                                    return 'When follicles are functioning properly, even simple care should be MORE than enough to get beautiful hair.';
                                  }
                                }(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              TextSpan(
                                text: FFLocalizations.of(context).getText(
                                  'h3j1paw8' /* 

The fact that  */
                                  ,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              TextSpan(
                                text: () {
                                  if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'hairConcern',
                                        answerIds: ['concern_hairloss'],
                                      ))) {
                                    return 'your hair loss ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'hairConcern',
                                        answerIds: ['concern_splitends'],
                                      ))) {
                                    return ' your split ends and dryness ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'hairConcern',
                                        answerIds: ['concern_scalp'],
                                      ))) {
                                    return 'your scalp issues ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'hairConcern',
                                        answerIds: ['concern_damage'],
                                      ))) {
                                    return 'so much hair damage ';
                                  } else {
                                    return 'your hair troubles ';
                                  }
                                }(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              TextSpan(
                                text: () {
                                  if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'concernDuration',
                                        answerIds: [
                                          'concernDuration_less6month'
                                        ],
                                      ))) {
                                    return 'has emerged ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'concernDuration',
                                        answerIds: ['concernDuration_6-1year'],
                                      ))) {
                                    return 'is still there after 6 months  ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'concernDuration',
                                        answerIds: ['concernDuration_1-2years'],
                                      ))) {
                                    return 'is still lingering after a year ';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'concernDuration',
                                        answerIds: ['concernDuration_2+years'],
                                      ))) {
                                    return 'is persistent through the years ';
                                  } else {
                                    return 'is still there ';
                                  }
                                }(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              TextSpan(
                                text: () {
                                  if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_basic'],
                                      ))) {
                                    return 'with such a simple routine shows that your follicles aren\'t functioning properly.';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_complex'],
                                      ))) {
                                    return 'while investing so much time and money clearly shows that your follicles are stuck in a bad cycle.';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_natural'],
                                      ))) {
                                    return 'despite following a natural routine means that something is keeping your follicles stuck in a bad cycle.';
                                  } else if (FFAppState()
                                      .quizProfile
                                      .qaPairs
                                      .contains(QuestionAnswerPairStruct(
                                        questionId: 'currentRoutine',
                                        answerIds: ['routine_intermediete'],
                                      ))) {
                                    return 'despite the extra care shows that your hair and follicles aren’t responding to the treatments like they should.';
                                  } else {
                                    return 'clearly shows that your follicles are stuck in a bad cycle & don’t benefit properly from the care you’re giving.';
                                  }
                                }(),
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize:
                                      MediaQuery.sizeOf(context).height < 500.0
                                          ? 13.0
                                          : 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.25,
                                ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: wrapWithModel(
                model: _model.footerButtonModel,
                updateCallback: () => safeSetState(() {}),
                child: FooterButtonWidget(
                  buttonOnTap: () async {
                    await widget.navigationTap?.call();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
