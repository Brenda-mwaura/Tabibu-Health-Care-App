import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                print(index);
                if (index == 2) {
                  setState(() {
                    _isLastPage = true;
                  });
                } else {
                  setState(() {
                    _isLastPage = false;
                  });
                }
              },
              children: [
                Column(
                  children: [
                    Expanded(
                      // flex: 3,
                      child: SizedBox(
                        // height: 200,
                        width: double.infinity,
                        child: SvgPicture.asset(
                          "assets/images/doc.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      //   flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome to Tabibu',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Tabibu is a platform that connects you to a doctor in a few minutes',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Page 2
                Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: SvgPicture.asset(
                          "assets/images/locate.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to Tabibu',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Tabibu is a platform that connects you to a doctor in a few minutes',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Page 3
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: SvgPicture.asset(
                            "assets/images/doctors.svg",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to Tabibu',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tabibu is a platform that connects you to a doctor in a few minutes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          color: Styles.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    effect: const WormEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      activeDotColor: Styles.primaryColor,
                      dotColor: Colors.grey,
                      spacing: 8,
                    ),
                    count: 3,
                  ),
                  _isLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.loginPage);
                          },
                          child: const Text(
                            "Done",
                            style: TextStyle(
                              color: Styles.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              color: Styles.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
