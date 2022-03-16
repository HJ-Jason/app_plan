import 'dart:ui';

import 'package:app_plan/widgets/routes/loadingScreen/loading_screen.dart';

import 'package:app_plan/widgets/routes/participationsPage/participations_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    CollectionReference event = FirebaseFirestore.instance.collection('Event');
    return FutureBuilder<DocumentSnapshot>(
        future: event.doc(args.toString()).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
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
              child: Scaffold(
                backgroundColor: Colors.transparent,
                // ---------- AppBar et titre de la page ---------- //
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBar(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back, size: 36),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: true,
                          title: Row(
                            children: const <Widget>[
                              SizedBox(
                                height: 60,
                                width: 60,
                              ),
                              Text(
                                'Détails',
                                style: TextStyle(
                                    fontSize: 42,
                                    fontFamily: 'Quigleyw',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                // ---------- Carte de l'événement -> Taille/couleurs/ombre ---------- //
                body: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 540,
                    width: 420,
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 48, 48, 48)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    // ---------- Carte de l'événement -> Bordures/Bannière ---------- //
                    child: Column(children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 49, 49, 49),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        // ---------- Titre de l'événement' ---------- //
                        child: Text(
                          '${data['Title']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      // ---------- Image de l'événement ---------- //
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          'https://media.discordapp.net/attachments/902535167850197022/935814927443165254/unknown.png',
                          fit: BoxFit.fill,
                          width: 250,
                          height: 150,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 232,
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 235, 235, 235),
                            width: 4,
                          ),
                        ),
                        // ---------- Lieu de l'événement ---------- //
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.location_on),
                            Text(
                              "${data['Location']}",
                            ),
                          ],
                        ),
                      ),
                      // ---------- Date de l'événement ---------- //
                      Container(
                        height: 32,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 235, 235, 235),
                            width: 4,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.calendar_today),
                            FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                    ' ${data['Date'].toDate().toString().split(" ")[0]} '
                                    '${data['Date'].toDate().toString().split(" ")[1].substring(0, 5)}')),
                          ],
                        ),
                      ),
                      // ---------- Description de l'événement ---------- //
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color.fromARGB(255, 235, 235, 235),
                                width: 4,
                              ),
                            ),
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              '${data['Description']}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      // ---------- Alerte personnalisable ---------- //
                      /*Container(
                        height: 32,
                        width: 210,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 223, 53, 53),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 223, 53, 53),
                            width: 4,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.bug_report),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                ' ${data['Option']}',
                              ),
                            )
                          ],
                        ),
                      ),*/
                      // ---------- Bouton s'inscire ou se désinscrire en fonction du cas ---------- //
                      _myEvent(idEvent: args.toString()),
                    ]),
                  ),
                ),
              ),
            );
          }
          return const LoadingScreen();
        });
  }
}

class _myEvent extends StatelessWidget {
  String? idEvent;
  _myEvent({Key? key, this.idEvent})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    CollectionReference userRef = FirebaseFirestore.instance
        .collection('User')
        .doc(result!.uid)
        .collection('MyEvent');
    return FutureBuilder(
        future: userRef.doc(idEvent.toString()).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.exists) {
              return NotInscriptionButton(context, idEvent);
            } else {
              return InscriptionButton(context, idEvent);
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Widget NotInscriptionButton(context, idEvent) {
  return TextButton.icon(
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Désinscription'),
        content: const Text('Quitter cet événement ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              deleteEvent(idEvent);
              Navigator.pop(context, 'Oui !');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ParticipationPage()));
            },
            child: const Text('Oui...'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Non !'),
            child: const Text('Non !'),
          ),
        ],
      ),
    ),
    icon: const Icon(Icons.remove_circle_outlined),
    label: const Text("Se désinscrire"),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 233, 17, 17),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  );
}

Widget InscriptionButton(context, idEvent) {
  return TextButton.icon(
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text("S'inscrire"),
        content: const Text("Voulez-vous vous inscrire à cet événement ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              addEvent(idEvent);
              Navigator.pop(context, 'Oui !');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ParticipationPage()));
            },
            child: const Text('Oui...'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Non !'),
            child: const Text('Non !'),
          ),
        ],
      ),
    ),
    icon: const Icon(Icons.check_circle),
    label: const Text("S'inscrire"),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 11, 151, 23),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  );
}

Future<void> addEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance
      .collection('User')
      .doc(result!.uid)
      .collection('MyEvent');
  return users
      .doc(idEvent)
      .set({
        'idEvent': idEvent,
      })
      .then((value) => print("IdEvent Added"))
      .catchError((error) => print("Failed to add : $error"));
}

Future<void> deleteEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance
      .collection('User')
      .doc(result!.uid)
      .collection('MyEvent');
  return users
      .doc(idEvent)
      .delete()
      .then((value) => print("IdEvent delete"))
      .catchError((error) => print("Failed to delete : $error"));
}
