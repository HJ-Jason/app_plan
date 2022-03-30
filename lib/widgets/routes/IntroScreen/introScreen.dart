import 'package:app_plan/widgets/routes/IntroScreen/verifEmail.dart';
import 'package:app_plan/widgets/routes/login/inscription_page.dart';
import 'package:app_plan/widgets/routes/login/menu_connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmail();
          } else {
            return ChoiceLogin();
          }
        });
  }
}
