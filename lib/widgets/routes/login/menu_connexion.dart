import 'package:app_plan/widgets/routes/login/inscription_page.dart';
import 'package:app_plan/widgets/routes/login/login.dart';
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            width: 300,
            height: 380,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    "Identifiez-vous",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.14),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.20,
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text(
                            "Connexion",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(36, 45, 165, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.20,
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text("S'inscrire",
                              style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/inscription',
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(36, 45, 165, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                    )
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
