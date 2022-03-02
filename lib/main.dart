import 'package:app_plan/widgets/routes/IntroScreen/introScreen.dart';
import 'package:app_plan/widgets/routes/eventDetails/event_details.dart';
import 'package:app_plan/widgets/routes/eventList/event_list.dart';
import 'package:app_plan/widgets/routes/login/login.dart';
import 'package:app_plan/widgets/routes/participationsPage/participations_page.dart';
import 'package:app_plan/widgets/routes/profilePage/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application de planification',
      theme: ThemeData(),
      home: IntroScreen(),
      routes: <String, WidgetBuilder>{
        '/details': (BuildContext context) => const EventDetails(),
        '/eventList': (BuildContext context) => const EventList(),
        '/login': (BuildContext context) => const Login(),
        '/profile': (BuildContext context) => const ProfilePage(),
        '/participation': (BuildContext context) => const ParticipationPage(),
      },
    );
  }
}
