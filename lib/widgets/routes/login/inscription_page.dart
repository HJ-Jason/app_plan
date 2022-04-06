import 'package:app_plan/services/auth.dart';
import 'package:app_plan/widgets/routes/IntroScreen/introScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../eventList/event_list.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _Inscription();
}

class _Inscription extends State<Inscription> {
  final AuthService auth = AuthService();
  final myControllerEmail = TextEditingController();
  final myControllerNom = TextEditingController();
  final myControllerPassWord = TextEditingController();
  final myControllerPrenom = TextEditingController();
  final myControllerCode = TextEditingController();
  String? code;

  String messageError = "";

  bool buttonState1 = true;
  bool buttonState2 = true;
  Icon usedIcon1 = const Icon(
    Icons.visibility_off,
    color: Colors.grey,
    size: 35,
  );
  Icon usedIcon2 = const Icon(
    Icons.visibility_off,
    color: Colors.grey,
    size: 35,
  );

  @override
  void initState() {
    super.initState();
    CheckCode();
  }

  CheckCode() async {
    await FirebaseFirestore.instance
        .collection('code')
        .doc('code')
        .get()
        .then((value) {
      setState(() {
        code = value.data()!['code'];
      });
    });
  }

  WhichIcon1() {
    buttonState1 = !buttonState1;
    if (buttonState1) {
      setState(() {
        usedIcon1 = const Icon(
          Icons.visibility_off,
          color: Colors.grey,
          size: 35,
        );
      });
    } else {
      setState(() {
        usedIcon1 = const Icon(
          Icons.visibility,
          color: Colors.blueAccent,
          size: 35,
        );
      });
    }
  }

  WhichIcon2() {
    buttonState2 = !buttonState2;
    if (buttonState2) {
      setState(() {
        usedIcon2 = const Icon(
          Icons.visibility_off,
          color: Colors.grey,
          size: 35,
        );
      });
    } else {
      setState(() {
        usedIcon2 = const Icon(
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
      resizeToAvoidBottomInset: false,
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
          height: 560,
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
          child: Center(
            child: Form(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Inscription',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  // ---------- Le Formulaire de Connexion ----------
                  //
                  TextFormField(
                      controller: myControllerNom,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: myControllerPrenom,
                      decoration: const InputDecoration(
                        labelText: 'Prénom',
                        border: OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 20,
                  ),

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
                                WhichIcon1();
                              },
                              icon: usedIcon1),
                        )),
                    obscureText: buttonState1,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    controller: myControllerCode,
                    decoration: InputDecoration(
                        labelText: 'Code',
                        border: const OutlineInputBorder(),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          child: IconButton(
                              onPressed: () {
                                WhichIcon2();
                              },
                              icon: usedIcon2),
                        )),
                    obscureText: buttonState2,
                  ),
                  const SizedBox(
                    height: 16,
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
                    height: 10,
                  ),
                  // ---------- Bouton de la Connexion ----------
                  //
                  TextButton(
                    child: const Text("S'inscrire"),
                    onPressed: () async {
                      if (code == myControllerCode.text) {
                        if (myControllerEmail.text.isNotEmpty &&
                            myControllerPassWord.text.isNotEmpty &&
                            myControllerNom.text.isNotEmpty &&
                            myControllerPrenom.text.isNotEmpty) {
                          if (myControllerPassWord.text.length >= 6) {
                            final user =
                                await auth.registerWithEmailAndPassword(
                                    myControllerEmail.text,
                                    myControllerPassWord.text);
                            await Future.delayed(
                                const Duration(milliseconds: 1000), () {
                              if (user == null) {
                                setState(() {
                                  messageError = "Une erreur est survenu !";
                                });
                              } else {
                                addUser(
                                    myControllerEmail.text,
                                    myControllerNom.text,
                                    myControllerPrenom.text);
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        IntroScreen(),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }
                            });
                          } else {
                            setState(() {
                              messageError =
                                  "Le mot de passe de contenir 6 caractères ou plus !";
                            });
                          }
                        } else {
                          setState(() {
                            messageError =
                                "Une erreur s'est produite lors de la saisie des informations!";
                          });
                        }
                      } else {
                        setState(() {
                          messageError = "Ceci n'est pas le bon code !";
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(36, 45, 165, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> addUser(email, nom, prenom) {
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  User? result = FirebaseAuth.instance.currentUser;
  return users
      .doc(result!.uid)
      .set({
        'Admin': false,
        'Email': email,
        'FirstName': prenom,
        'LastName': nom,
        'MyEvent': FieldValue.arrayUnion([]),
        'Picture':
            "https://media.discordapp.net/attachments/902535167850197022/935551661001302026/Clem.jpg?width=661&height=663",
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
