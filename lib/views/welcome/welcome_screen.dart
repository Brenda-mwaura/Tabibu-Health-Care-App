import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome to Tabibu",
      body:
          "Tabibu is a platform that helps you locate the nearest clinic and book appointments at the comfort of your home",
      image: Center(
        child: SvgPicture.asset('assets/images/doctors.svg'),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    //page 2
    PageViewModel(
      title: "Book an appointment",
      body:
          "Book an appointment at your preferred clinic and get an instant confirmation",
      image: Center(
        child: SvgPicture.asset('assets/images/medical_research.svg'),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ),
    //page 3
    PageViewModel(
      title: "Quality Healthcare",
      body:
          "Get quality healthcare from the best doctors in the country with no hassle",
      image: Center(
        child: SvgPicture.asset('assets/images/doc.svg'),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: Colors.grey,
            activeSize: Size.square(20),
            activeColor: Colors.red,
          ),
          showDoneButton: true,
          done: const Text(
            'Done',
            style: TextStyle(fontSize: 20),
          ),
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(fontSize: 20),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 25,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    Navigator.pushReplacementNamed(
      context,
      RouteGenerator.loginPage,
    );
  }
}















    // child: Stack(
    //       children: [
    //         PageView(
    //           controller: _controller,
    //           onPageChanged: (index) {
    //             print(index);
    //             if (index == 2) {
    //               setState(() {
    //                 _isLastPage = true;
    //               });
    //             } else {
    //               setState(() {
    //                 _isLastPage = false;
    //               });
    //             }
    //           },
    //           children: [
    //             Column(
    //               children: [
                  
    //               ],
    //             ),
    //             // Column(
    //             //   children: [
    //             //     Expanded(
    //             //       flex: 2,
    //             //       child: SizedBox(
    //             //         // height: 200,
    //             //         width: double.infinity,
    //             //         child: SvgPicture.asset(
    //             //           "assets/images/doc.svg",
    //             //           fit: BoxFit.contain,
    //             //         ),
    //             //       ),
    //             //     ),
    //             //     Expanded(
    //             //       flex: 3,
    //             //       child: Container(
    //             //         padding: EdgeInsets.symmetric(horizontal: 20),
    //             //         child: Column(
    //             //           mainAxisAlignment: MainAxisAlignment.center,
    //             //           crossAxisAlignment: CrossAxisAlignment.start,
    //             //           children: const [
    //             //             Text(
    //             //               'Welcome to Tabibu',
    //             //               style: TextStyle(
    //             //                 fontSize: 24,
    //             //                 fontWeight: FontWeight.bold,
    //             //               ),
    //             //             ),
    //             //             SizedBox(
    //             //               height: 10,
    //             //             ),
    //             //             Text(
    //             //               'Tabibu is a platform that connects you to a doctor in a few minutes',
    //             //               style: TextStyle(
    //             //                 fontSize: 16,
    //             //                 color: Colors.grey,
    //             //               ),
    //             //             ),
    //             //           ],
    //             //         ),
    //             //       ),
    //             //     ),
    //             //   ],
    //             // ),
    //             // Page 2
    //             Column(
    //               children: [
    //                 Expanded(
    //                   flex: 3,
    //                   child: SizedBox(
    //                     height: 200,
    //                     width: double.infinity,
    //                     child: SvgPicture.asset(
    //                       "assets/images/locate.svg",
    //                       fit: BoxFit.contain,
    //                     ),
    //                   ),
    //                 ),
    //                 Expanded(
    //                   flex: 2,
    //                   child: Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 20),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Welcome to Tabibu',
    //                           style: TextStyle(
    //                             fontSize: 24,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text(
    //                           'Tabibu is a platform that connects you to a doctor in a few minutes',
    //                           style: TextStyle(
    //                             fontSize: 16,
    //                             color: Colors.grey,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             // Page 3
    //             Container(
    //               child: Column(
    //                 children: [
    //                   Expanded(
    //                     flex: 3,
    //                     child: SizedBox(
    //                       height: 200,
    //                       width: double.infinity,
    //                       child: SvgPicture.asset(
    //                         "assets/images/doctors.svg",
    //                         fit: BoxFit.contain,
    //                       ),
    //                     ),
    //                   ),
    //                   Expanded(
    //                     flex: 2,
    //                     child: Container(
    //                       padding: EdgeInsets.symmetric(horizontal: 20),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             'Welcome to Tabibu',
    //                             style: TextStyle(
    //                               fontSize: 24,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Text(
    //                             'Tabibu is a platform that connects you to a doctor in a few minutes',
    //                             style: TextStyle(
    //                               fontSize: 16,
    //                               color: Colors.grey,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         Container(
    //           alignment: const Alignment(0, 0.80),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   _controller.animateToPage(
    //                     3,
    //                     duration: const Duration(milliseconds: 500),
    //                     curve: Curves.ease,
    //                   );
    //                 },
    //                 child: const Text(
    //                   "Skip",
    //                   style: TextStyle(
    //                       color: Styles.primaryColor,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //               ),
    //               SmoothPageIndicator(
    //                 controller: _controller,
    //                 effect: const WormEffect(
    //                   dotHeight: 15,
    //                   dotWidth: 15,
    //                   activeDotColor: Styles.primaryColor,
    //                   dotColor: Colors.grey,
    //                   spacing: 8,
    //                 ),
    //                 count: 3,
    //               ),
    //               _isLastPage
    //                   ? GestureDetector(
    //                       onTap: () {
    //                         Navigator.of(context)
    //                             .pushNamed(RouteGenerator.loginPage);
    //                       },
    //                       child: const Text(
    //                         "Done",
    //                         style: TextStyle(
    //                           color: Styles.primaryColor,
    //                           fontSize: 18,
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       ),
    //                     )
    //                   : GestureDetector(
    //                       onTap: () {
    //                         _controller.nextPage(
    //                           duration: const Duration(milliseconds: 500),
    //                           curve: Curves.ease,
    //                         );
    //                       },
    //                       child: const Text(
    //                         "Next",
    //                         style: TextStyle(
    //                           color: Styles.primaryColor,
    //                           fontSize: 18,
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       )),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),