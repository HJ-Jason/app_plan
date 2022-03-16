import 'package:app_plan/services/auth.dart';
import 'package:app_plan/widgets/routes/eventList/event_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

int itemCount = 5;
List<bool> selected = <bool>[];

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final AuthService auth = AuthService();
  final myControllerEmail = TextEditingController();
  final myControllerPassWord = TextEditingController();
  String messageError = "";

  bool buttonState = true;

  Icon usedIcon = const Icon(
    Icons.visibility_off,
    color: Colors.grey,
    size: 35,
  );

  WhichIcon() {
    buttonState = !buttonState;
    if (buttonState) {
      setState(() {
        usedIcon = const Icon(
          Icons.visibility_off,
          color: Colors.grey,
          size: 35,
        );
      });
    } else {
      setState(() {
        usedIcon = const Icon(
          Icons.visibility,
          color: Colors.blueAccent,
          size: 35,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // -------------------------- Screen de l'application -----------------------
    //
    return Scaffold(
      // ------------------------ Entete de l'application -----------------------
      //
      backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        elevation: 0.0,
        title: const Text(
          'Bienvenue',
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Roboto',
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),

      // --------------------- Block du Login -------------------------
      //
      body: Center(
        child: Container(
            width: 300,
            height: 420,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    spreadRadius: 5,
                    blurRadius: 29,
                    offset: Offset(0, 0))
              ],
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Connexion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  // ---------- Le Formulaire de Connexion ----------
                  //
                  TextFormField(
                      controller: myControllerEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myControllerPassWord,
                    decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: const OutlineInputBorder(),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          child: IconButton(
                              onPressed: () {
                                WhichIcon();
                              },
                              icon: usedIcon),
                        )),
                    obscureText: buttonState,
                  ),

                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    messageError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  // ---------- Bouton de la Connexion ----------
                  //
                  TextButton(
                    child: const Text("Connexion"),
                    onPressed: () async {
                      auth.signInWithEmailAndPassword(
                          myControllerEmail.text, myControllerPassWord.text);
                      await Future.delayed(new Duration(milliseconds: 1000),
                          () {
                        User? _user = FirebaseAuth.instance.currentUser;
                        if (_user != null) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const EventList(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                          );
                        } else {
                          setState(() {
                            messageError = "Une erreur est survenu !";
                          });
                        }
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(36, 45, 165, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),

                  // ---------- Bouton de Réinitialisation de Mot de passe ----------
                  //
                  TextButton(
                      onPressed: () {},
                      child: const Text('Mot de passe oublié ?'))
                ],
              ),
            )),
      ),

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: const [
      //     Text(
      //       'Bienvenue',
      //       style: TextStyle(
      //           fontSize: 35, fontFamily: 'Roboto', color: Colors.black),
      //     ),
      //   ],
      // ),
    );
  }
}
