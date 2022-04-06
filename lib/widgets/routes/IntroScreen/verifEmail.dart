import 'dart:async';

import 'package:app_plan/widgets/routes/eventList/event_list.dart';
import 'package:app_plan/widgets/routes/login/menu_connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResetEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResetEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResetEmail = true);
    } catch (e) {
      print("error verif email");
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const EventList()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
            title: const Text('Vérification de l\'email'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Un email de vérification a été envoyé sur votre boîte mail.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'La connexion se fera automatiquement depuis cette page une fois votre email vérifié.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.warning_amber_rounded, color: Colors.red),
                    Text(
                      ' Pensez à vérifier vos spams ! ',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.warning_amber_rounded, color: Colors.red),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(36, 45, 165, 1),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(
                    Icons.email,
                    size: 32,
                  ),
                  label: const Text(
                    'Renvoyer le mail',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: canResetEmail ? sendVerificationEmail : () {},
                ),
                const SizedBox(height: 8),
                TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(36, 45, 165, 1),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ChoiceLogin(),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Retour',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    )),
              ],
            ),
          ),
        );
}
