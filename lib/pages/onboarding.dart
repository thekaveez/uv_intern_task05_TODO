import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/components/my_button.dart';
import 'package:uv_intern_task05_todo/pages/onboard_screens/screen1.dart';
import 'package:uv_intern_task05_todo/pages/welcome_page.dart';

import 'onboard_screens/screen2.dart';
import 'onboard_screens/screen3.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  PageController _controller = PageController();

  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [

          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                _isLastPage = (index == 2);
              });
            },
            children:  const [
              Screen1(),
              Screen2(),
              Screen3(),
            ],
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                  child: Text(
                    'BACK',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                MyButton(
                  title: _isLastPage ? 'GET STARTED' : 'NEXT',
                  color: 0xFF8875FF,
                  onTap: (){
                    if(_isLastPage){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
                    }else{
                      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    }
                  },
                )
              ],
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: GestureDetector(
              onTap: (){
                _controller.jumpToPage(2);
              },
              child: Text(
                'SKIP',
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

