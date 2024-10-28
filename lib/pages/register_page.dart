import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/helper/helper_functions.dart';
import 'package:uv_intern_task05_todo/serrvices/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  // Register method
  void registerUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessageToUser("Passwords don't match", context);
    }else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );

        // create new user
        createUserDocument(userCredential);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.message ?? 'Registration failed', context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null){
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set({
        'email': userCredential.user!.email,
      });
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
                  'Register',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 24),
                MyTextFormField(
                  controller: confirmPasswordController,
                  title: 'Confirm Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                ),


                const SizedBox(height: 48),

                MyButton(
                  isFullWidth: true,
                  title: 'Register',
                  color: 0xff8875FF,
                  onTap: () {
                    registerUser();
                  },
                ),
                const SizedBox(height: 24),

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
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.lato(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        ' Login',
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
