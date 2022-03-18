import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.2,
                0.6,
                0.8,
              ],
              colors: <Color>[
                Color.fromRGBO(36, 45, 165, 1.0),
                Color.fromRGBO(39, 50, 185, 1.0),
                Color.fromRGBO(13, 19, 132, 1.0)
              ]),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Une erreur est survenue...",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 26),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Réessayer",
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )))
          ]),
        ),
      ),
    );
  }
}
