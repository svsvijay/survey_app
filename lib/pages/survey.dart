import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:survey_kit/survey_kit.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getJsonTask(),
              builder: (BuildContext context, AsyncSnapshot<Task> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final Task task = snapshot.data!;
                  var data = task.id.toJson();

                  return SurveyKit(
                      appBar: (appBarConfiguration) {
                        return Container(
                          child: Text(data.toString()),
                        );
                      },
                      onResult: (SurveyResult result) {
                        print(result.toJson());
                        // Navigator.pushNamed(context, '/');
                      },
                      task: task,
                      // showProgress: true,
                      localizations: const <String, String>{
                        'cancel': 'Cancel',
                        'next': 'Next',
                      },
                      themeData: Theme.of(context).copyWith(
                        primaryColor: Colors.cyan,
                        appBarTheme: const AppBarTheme(
                          color: Colors.white,
                          iconTheme: IconThemeData(
                            color: Colors.cyan,
                          ),
                          titleTextStyle: TextStyle(
                            color: Colors.cyan,
                          ),
                        ),
                        iconTheme: const IconThemeData(
                          color: Colors.cyan,
                        ),
                        textSelectionTheme: const TextSelectionThemeData(
                          cursorColor: Colors.cyan,
                          selectionColor: Colors.cyan,
                          selectionHandleColor: Colors.cyan,
                        ),
                        cupertinoOverrideTheme: const CupertinoThemeData(
                          primaryColor: Colors.cyan,
                        ),
                        outlinedButtonTheme: OutlinedButtonThemeData(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(150.0, 60.0),
                            ),
                            side: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> state) {
                                if (state.contains(MaterialState.disabled)) {
                                  return const BorderSide(
                                    color: Colors.grey,
                                  );
                                }
                                return const BorderSide(
                                  color: Colors.cyan,
                                );
                              },
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            textStyle: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> state) {
                                if (state.contains(MaterialState.disabled)) {
                                  return Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.grey,
                                      );
                                }
                                return Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.cyan,
                                    );
                              },
                            ),
                          ),
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.cyan,
                                  ),
                            ),
                          ),
                        ),
                        textTheme: const TextTheme(
                          displayMedium: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                          ),
                          headlineSmall: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                          bodyMedium: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          titleMedium: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        inputDecorationTheme: const InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: Colors.cyan,
                        )
                            .copyWith(
                              onPrimary: Colors.white,
                            )
                            .copyWith(background: Colors.white),
                      ),
                      surveyProgressbarConfiguration: null);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Task> getJsonTask() async {
    final String taskJson = await rootBundle.loadString('en.json');
    final Map<String, dynamic> taskMap = json.decode(taskJson);
    print(taskMap);
    return Task.fromJson(taskMap);
  }
}