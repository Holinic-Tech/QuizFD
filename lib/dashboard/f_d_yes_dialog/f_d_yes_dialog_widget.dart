import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'f_d_yes_dialog_model.dart';
export 'f_d_yes_dialog_model.dart';

/// Personal plan dialog
///
class FDYesDialogWidget extends StatefulWidget {
  const FDYesDialogWidget({super.key});

  @override
  State<FDYesDialogWidget> createState() => _FDYesDialogWidgetState();
}

class _FDYesDialogWidgetState extends State<FDYesDialogWidget> {
  late FDYesDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FDYesDialogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On component dispose action.
    () async {
      await actions.trackGAEvent(
        'Closed Skip Dialog',
        '',
        '',
        FFAppConstants.nonQuestionAnswerItem.toList(),
        '',
        '',
      );
      context.safePop();
    }();

    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: valueOrDefault<double>(
          () {
            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
              return 500.0;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
              return 500.0;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
              return 500.0;
            } else {
              return 500.0;
            }
          }(),
          500.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryWhite,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await actions.trackGAEvent(
                          'Closed Skip Dialog',
                          '',
                          '',
                          FFAppConstants.nonQuestionAnswerItem.toList(),
                          '',
                          '',
                        );
                        context.safePop();
                      },
                      child: Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryViolet,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Color(0x863A2D32),
                          size: 22.0,
                        ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'nwsgpatn' /* ⚠️ Are you sure? */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(25.0, 20.0, 25.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '8qazjcwh' /* some text about follicle dysfu... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await actions.trackGAEvent(
                              'Closed Skip Dialog',
                              '',
                              '',
                              FFAppConstants.nonQuestionAnswerItem.toList(),
                              '',
                              '',
                            );
                            context.safePop();
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).orange,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).orange,
                                width: 2.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 5.0
                                          : 20.0,
                                      20.0,
                                    ),
                                    12.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 5.0
                                          : 20.0,
                                      20.0,
                                    ),
                                    12.0),
                                child: AutoSizeText(
                                  FFLocalizations.of(context).getText(
                                    '01k9emv9' /* BACK */,
                                  ),
                                  minFontSize: 14.0,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryWhite,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await actions.trackGAEvent(
                              'Question Answered',
                              'diagnosisFD',
                              'See if the Challenge is a fit for you and your hair profile',
                              FFAppConstants.yes.toList(),
                              '',
                              '',
                            );
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            decoration: BoxDecoration(
                              color: Color(0x2CFF6E00),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).orange,
                                width: 2.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 5.0
                                          : 20.0,
                                      20.0,
                                    ),
                                    12.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 5.0
                                          : 20.0,
                                      20.0,
                                    ),
                                    12.0),
                                child: AutoSizeText(
                                  FFLocalizations.of(context).getText(
                                    '3f7zyu7g' /* CONTINUE */,
                                  ),
                                  minFontSize: 14.0,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xE1FF6E00),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 20.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
