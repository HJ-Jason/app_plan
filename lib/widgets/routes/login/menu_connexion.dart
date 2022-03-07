import 'package:flutter/material.dart';

class ChoiceLogin extends StatefulWidget {
  const ChoiceLogin({Key? key}) : super(key: key);

  @override
  State<ChoiceLogin> createState() => _ChoiceLogin();
}

class _ChoiceLogin extends State<ChoiceLogin> {
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
          child: Card(
        child: Container(
          width: 300,
          height: 400,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
      )),
    );
  }
}
