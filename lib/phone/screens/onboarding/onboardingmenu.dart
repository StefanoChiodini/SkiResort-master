import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ski_resorts_app/constants/text_constants.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';

class OnboardingMenu extends StatefulWidget {
  const OnboardingMenu({super.key});

  @override
  State<OnboardingMenu> createState() => _OnboardingMenuState();
}

class _OnboardingMenuState extends State<OnboardingMenu> {
  final PageController controller = PageController();
  bool isPressed = false;
  late Timer splashTimeout = Timer(const Duration(milliseconds: 5000), () {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // riga in alto con i due bottoni
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2.0, top: 8.0),
                child: skipbutton(context, 'Skip', const LoginPage()),
              ),
            ],
          ),
          SizedBox(
              height: 600,
              child: PageView(
                controller: controller,
                children: <Widget>[
                  centralBlock(
                      context: context,
                      imagePath: PathConstants.onboarding1,
                      mainText: TextConstants.onboarding1Description,
                      title: TextConstants.onboarding1Title,
                      callback: setState,
                      isPressed: isPressed,
                      splashTimeout: splashTimeout),
                  centralBlock(
                      context: context,
                      imagePath: PathConstants.onboarding2,
                      mainText: TextConstants.onboarding2Description,
                      title: TextConstants.onboarding2Title,
                      callback: setState,
                      isPressed: isPressed,
                      splashTimeout: splashTimeout),
                  centralBlock(
                      context: context,
                      imagePath: PathConstants.onboarding3,
                      mainText: TextConstants.onboarding3Description,
                      title: TextConstants.onboarding3Title,
                      endbutton: true,
                      callback: setState,
                      isPressed: isPressed,
                      splashTimeout: splashTimeout),
                ],
              )),
          smoothindicator(
              controller, Colors.lightBlueAccent, Colors.lightBlueAccent)
        ],
      ),
    );
  }
}

// three dots at the end of the page to change onboarding page
Widget smoothindicator(
    PageController controller, Color activeDotcolor, Color dotColor) {
  return SmoothPageIndicator(
    controller: controller,
    count: 3,
    effect: JumpingDotEffect(
        activeDotColor: activeDotcolor,
        dotColor: dotColor.withOpacity(0.5),
        dotHeight: 25,
        dotWidth: 25),
  );
}

Widget skipbutton(BuildContext context, String text, Widget pushed) {
  return TextButton(
      style: TextButton.styleFrom(
        animationDuration: const Duration(milliseconds: 200),
        minimumSize: const Size(150, 50),
        foregroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(50),
        )),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pushed,
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ));
}

Widget centralBlock(
    {required BuildContext context,
    required String imagePath,
    required String title,
    required String mainText,
    bool endbutton = false,
    required var callback,
    required bool isPressed,
    required var splashTimeout}) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Column(children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            scale: 0.60,
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              //spaziatura del secondo paragrafo
              horizontal: screenWidth / 100,
            ),
            child: Text(
              mainText,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // only for the last page insert the button to Login/Register
          endbutton
              ? Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(310, 55),
                          backgroundColor: Colors.blue,
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const InkWell(
                        child: Text(
                          'Explore now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox(height: 0)
        ],
      ),
    ),
  ]);
}
