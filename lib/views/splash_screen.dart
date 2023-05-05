import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants/constants.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'views.dart';

class SplashScreenView extends StatefulWidget {
  SplashScreenView({Key key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(AppSettings.BOXNAME);
    startTime();
  }

  void navigationPage() async {
    bool doneOnboarding = false;

    doneOnboarding = box.get(AppSettings.FINISHEDONBOARDING) ?? false;
    NavigationService().pushReplacement(
      doneOnboarding
          ? DashBoard()
          : OnboardingView(
              fromDashboard: false,
            ),
    );
  }

  startTime() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Center(
                child: Pulser(
                  duration: 800,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.3,
                    image: AssetImage(
                      whiteLogo,
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
