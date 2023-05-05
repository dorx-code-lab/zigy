import 'package:concentric_transition/page_view.dart';
import 'package:zigy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zigy/services/services.dart';
import 'package:zigy/views/views.dart';
import '../../constants/constants.dart';

class OnboardingView extends StatefulWidget {
  final bool fromDashboard;
  OnboardingView({
    Key key,
    @required this.fromDashboard,
  }) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  Box box;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box(AppSettings.BOXNAME);
  }

  @override
  Widget build(BuildContext context) {
    final List<OnBoardingItem> dayta = [
      OnBoardingItem(
        "Welcome to the Zigy App",
        welcome,
        "This app is just a demo",
      ),
      OnBoardingItem(
        "View users and stuff",
        userPic,
        "View all user data, test the API at Reqres and enjoy seeing random dummy data.",
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          ConcentricPageView(
            duration: Duration(
              milliseconds: 1000,
            ),
            verticalPosition: 0.8,
            onFinish: () async {
              box.put(
                AppSettings.FINISHEDONBOARDING,
                true,
              );

              if (widget.fromDashboard) {
                NavigationService().pop();
              } else {
                NavigationService().popToFirst(context);
                NavigationService().pushReplacement(DashBoard());
              }
            },
            colors: <Color>[
              Colors.orange,
              Colors.black,
            ],
            itemCount: dayta.length, // null = infinity
            nextButtonBuilder: (context) {
              return CircleAvatar(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              );
            },
            itemBuilder: (int index) {
              return SingleOnboardingPage(
                item: dayta[index],
              );
            },
          ),
          Positioned(
            top: 10,
            right: 10,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  UserfulServices().launchTheThing(companyWebsite);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: primaryColor,
                    elevation: standardElevation,
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: UIServices().getImageProvider(
                          whiteLogo,
                        ),
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleOnboardingPage extends StatelessWidget {
  final OnBoardingItem item;

  const SingleOnboardingPage({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                item.image,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              item.desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
