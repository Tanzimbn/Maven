import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/splashService.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_application_1/page/home_page.dart';

class welcome_page extends StatefulWidget {
  const welcome_page({Key? key}) : super(key:key);
  @override
  State<welcome_page> createState() => _welcome_pageState();
}

class _welcome_pageState extends State<welcome_page> {
  splashService splashScreen = splashService();

  void initState() {
    super.initState();
    // splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcom to MAVEN",
          body: "Elevate Everyday Excellence: Learn and Teach Life's Skills with Maven!",
          image: logobuildImage('assets/images/1.png'),
          decoration: getdecoration()
        ),
        PageViewModel(
          title: "Empower with Expertise",
          body: "Welcome, Expert! Share your knowledge and skills with the world. Teach, inspire, and shape the future through your expertise. Flutter awaits your insights!",
          image: buildImage('assets/images/expert.png'),
          decoration: getdecoration()
        ),
        PageViewModel(
          title: "Journey to Mastery",
          body: "Hello, Learner! Embark on your journey to mastery. Explore new skills, absorb knowledge, and grow with Flutter. The path to success begins with your eager mind.",
          image: buildImage('assets/images/student.png'),
          decoration: getdecoration()
        ),
        PageViewModel(
          title: "Celebrate Achievements",
          body: "Congratulations, Achiever! Reach new heights and be recognized for your dedication. Unlock rewards, showcase your accomplishments, and inspire others with your Flutter success story.",
          image: buildImage('assets/images/reward.png'),
          decoration: getdecoration()
        )
      ],
      done: Text('Go', style: TextStyle(fontWeight: FontWeight.w600),),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text('Skip'),
      onSkip: () => goToHome(context), 
      skipStyle: TextButton.styleFrom(primary: AppColor.primary),  
      doneStyle: TextButton.styleFrom(primary: AppColor.primary), 
      next: Icon(Icons.arrow_forward),
      nextStyle: TextButton.styleFrom(primary: AppColor.primary),
      dotsDecorator: getDotDecoration(),
    )
  );

  void goToHome(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LogIn()),
  );

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: AppColor.primary,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));
  
  Widget logobuildImage(String path) =>
      Center(child: Image.asset(path, width: 350, color: AppColor.primary,));

  PageDecoration getdecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'Oskwald', fontWeight: FontWeight.bold, color: AppColor.textColor),
    bodyTextStyle: TextStyle(fontSize: 12, color: AppColor.textColor, fontFamily: 'Oskwald'),
    bodyPadding: EdgeInsets.all(6).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(14),
    pageColor: const Color.fromARGB(255, 255, 255, 255),
  );
}