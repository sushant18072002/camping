import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/Menu.dart';
import 'package:task2/screen/add_trip_form.dart';
import 'package:task2/screen/main_page.dart';
import 'package:task2/screen/sign_up.dart';

import '../CustumWidget/button_ui.dart';
import '../Utilities/smooth_page_indicator.dart';
import 'Login/login.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //DimensionManager().initialize();
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(child: SmoothpageIndicator()),
            Padding(
              padding:DimensionManager.fromLTRB(20,40,20),
              child: ButtonUi.filledbutton( Login(), "Log in ")
            ),
            Container(
                padding: DimensionManager.fromLTRB(20,16,0,20),
                //EdgeInsets.fromLTRB(div(width, 20), div(height, 16), 0, div(width, 20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an Account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorManager.textColor1),
                    ),
                    GestureDetector(
                      onTap:() => Navigator.push(
                          MyApp.navigatorKey.currentContext!,
                          MaterialPageRoute(builder: (context) => SignUp())),
                      child: Text(
                        " Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorManager.textColor1),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class SmoothpageIndicator extends StatefulWidget {

  @override
  _SmoothpageIndicator createState() => _SmoothpageIndicator();
}

class _SmoothpageIndicator extends State<SmoothpageIndicator> {
  final controller = PageController(viewportFraction: 1.48, keepPage: true);
  final List<Map<String, String>> _SmoothPageDetails = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Your Tasks",
      "dis":
          "I always reminds you about your planned\n activities. which is always my priority and \nyour importance."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Capture Your Memories",
      "dis":
          "We know that catching photos are \n necessary in your trip. that’s why we have\n built-in camera and gallery feature."
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Track Your Fitness",
      "dis":
          "Fitness is one of the main thing which is\n really inportant to your body and we track it \n in every second."
    },
    {
      "image": "assets/images/onboarding4.png",
      "title": "There Is Much More",
      "dis":
          "We have bunch of other cool features.\n which is super helpful for your next camping trip.\n so what are you waiting for?"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height:DimensionManager.divH(548),
          child: PageView.builder(
            controller: controller,
            itemCount: _SmoothPageDetails.length,
            itemBuilder: (_, index) {
              return SmoothPageDetails(
                  DimensionManager.height,
                  index,
                  _SmoothPageDetails[index ]["image"],
                  _SmoothPageDetails[index ]["title"],
                  _SmoothPageDetails[index]["dis"]);
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: _SmoothPageDetails.length,
          effect:  ScrollingDotsEffect(
            fixedCenter:true,
            radius: 8,
            activeDotColor: ColorManager.green84CC16,
            dotColor: ColorManager.colorD9F99D,
            dotWidth: 8,
            dotHeight: 8,
            activeDotScale:2,
            // strokeWidth: 5,
          ),
        ),
      ],
    );
  }
}
