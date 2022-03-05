import 'package:app_plan/widgets/routes/login/inscription_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../eventList/event_list.dart';
import '../login/login.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    if (result == null) {
      return const Login();
    }
    return const EventList();
  }
}
