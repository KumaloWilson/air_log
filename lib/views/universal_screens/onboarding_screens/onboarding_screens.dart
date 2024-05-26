import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/colors.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../helpers/shared_preferances_helper.dart';
import '../authorization_screens/auth_handler.dart';


class OnBoardingPage extends StatefulWidget {
  final Widget introPage1;
  final Widget introPage2;
  final Widget introPage3;


  const OnBoardingPage({super.key, required this.introPage1, required this.introPage2, required this.introPage3, });

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}



class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();


  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
         PageView(
                controller: _controller,
                onPageChanged: (index){
                  setState(() {
                    if(index == 2)
                    {
                      onLastPage = true;
                    }
                    else
                    {
                      onLastPage = false;
                    }
                  });
                },
                children: [
                  widget.introPage1,
                  widget.introPage2,
                  widget.introPage3,
                ],
              ),
          Container(
              alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          color: Pallete.primaryColor,
                          fontWeight: FontWeight.bold
                      ),

                    ),
                    onTap: (){
                      _controller.jumpToPage(2);
                    },
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: WormEffect(
                      spacing:  5.0,
                      dotColor:  Pallete.primaryColor.withOpacity(0.2),
                      activeDotColor: Pallete.primaryColor,
                    ),
                  ),
                  if (onLastPage == true) GestureDetector(
                    child: const Text(
                      'Done',
                      style: TextStyle(
                          color: Pallete.primaryColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () async{
                      await SharedPreferencesHelper.updateOnboardingStatus(true);
                      Helpers.permanentNavigator(context, const AuthHandler());
                    },
                  ) else GestureDetector(
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Pallete.primaryColor,
                          fontWeight: FontWeight.bold
                      ),

                    ),
                    onTap: (){
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubicEmphasized);
                    },
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
