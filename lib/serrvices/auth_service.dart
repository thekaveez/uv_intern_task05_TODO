
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uv_intern_task05_todo/auth/auth_page.dart';

import '../helper/helper_functions.dart';

class AuthService{
  Future<void> signInWithGoogle(BuildContext context)  async{

    try{
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          );

      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null) {
        Navigator.pop(context);
        return;
      }

        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if(userCredential.user != null){

          String email = userCredential.user!.email!;
          await FirebaseFirestore.instance.collection('users').doc(email).set({
            'email': email,
            // 'name': userCredential.user!.displayName,
            // 'profilePic': userCredential.user!.photoURL,
          });
          Navigator.pop(context);
          Navigator.pushNamed(context, '/auth');
        }
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.pop(context);
      displayMessageToUser(e.message ?? 'Error signing in with Google: ${e.toString()}', context);
    }


  }
}