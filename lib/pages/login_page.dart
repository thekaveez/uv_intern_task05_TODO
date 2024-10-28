import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/components/my_text_form_field.dart';
import 'package:uv_intern_task05_todo/helper/helper_functions.dart';
import 'package:uv_intern_task05_todo/serrvices/auth_service.dart';
import '../components/my_button.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  // Login method
  void loginUser() async {

    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/auth');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 64),
                MyTextFormField(
                    controller: usernameController,
                    title: 'Username',
                    hintText: 'Enter your username',
                    obscureText: false,
                ),
                const SizedBox(height: 24),
                MyTextFormField(
                  controller: passwordController,
                  title: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                ),


                const SizedBox(height: 72),

                MyButton(
                  isFullWidth: true,
                  title: 'Login',
                  color: 0xff8875FF,
                  onTap: () {
                    loginUser();
                  },
                ),
                const SizedBox(height: 42),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                MyButton(
                  isFullWidth: true,
                  isOutlined: true,
                  isIcon: true,
                  imgPath: 'assets/google_logo.png',
                  title: 'Login with Google',
                  color: 0xff8875FF,
                  onTap: () {
                    AuthService().signInWithGoogle(context);
                  },
                ),
                const SizedBox(height: 24),
                MyButton(
                  isFullWidth: true,
                  isOutlined: true,
                  isIcon: true,
                  imgPath: 'assets/apple_logo.png',
                  title: 'Login with Apple',
                  color: 0xff8875FF,
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.lato(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        ' Register',
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
