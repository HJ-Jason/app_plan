import 'package:app_plan/widgets/routes/loadingScreen/loading_screen.dart';
import 'package:app_plan/widgets/routes/participationsPage/participations_page.dart';
import 'package:intl/intl.dart';
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
            DateTime date = (data['Date'].toDate());
            var format = DateFormat('dd/MM/yyyy');
            var goodDate = format.format(date);
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
                                width: 60,
                              ),
                              Text(
                                'Détails',
                                style: TextStyle(
                                    fontSize: 36,
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
                    height: 580,
                    width: 420,
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
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
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0),
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
                          'https://firebasestorage.googleapis.com/v0/b/planification-8efe7.appspot.com/o/images%2Fillustration.png?alt=media&token=c492d240-c7b5-44fe-8367-ffd2e74215c7',
                          fit: BoxFit.fill,
                          width: 180,
                          height: 180,
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
                        width: 140,
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
                                // ignore: unnecessary_brace_in_string_interps
                                child: Text(" ${goodDate}")),
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
    CollectionReference userRef = FirebaseFirestore.instance.collection('User');
    bool contains(data, idEvent) {
      bool boolean = false;
      for (var d in data) {
        if (d == idEvent) {
          boolean = true;
        }
      }
      return boolean;
    }

    return FutureBuilder(
        future: userRef.doc(result!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if (contains(data['MyEvent'], idEvent)) {
              return NotInscriptionButton(context, idEvent);
            } else {
              return InscriptionButton(context, idEvent);
            }
          } else {
            return const Text("");
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
              deleteCountEvent(idEvent);
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
              addCountEvent(idEvent);
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
        const Color.fromARGB(255, 7, 57, 194),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  );
}

Future<void> addEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  return users
      .doc(result!.uid)
      .update({
        'MyEvent': FieldValue.arrayUnion([idEvent]),
      })
      .then((value) => print("IdEvent Added"))
      .catchError((error) => print("Failed to add : $error"));
}

Future<void> addCountEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference event = FirebaseFirestore.instance.collection('Event');
  return event
      .doc(idEvent)
      .update({
        'Users': FieldValue.arrayUnion([result!.uid])
      })
      .then((value) => print("Event Updated User"))
      .catchError((error) => print("Failed to update event: $error"));
  ;
}

Future<void> deleteEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  return users
      .doc(result!.uid)
      .update({
        'MyEvent': FieldValue.arrayRemove([idEvent])
      })
      .then((value) => print("IdEvent delete"))
      .catchError((error) => print("Failed to delete : $error"));
}

Future<void> deleteCountEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference event = FirebaseFirestore.instance.collection('Event');
  return event
      .doc(idEvent)
      .update({
        'Users': FieldValue.arrayRemove([result!.uid])
      })
      .then((value) => print("Event Updated User"))
      .catchError((error) => print("Failed to update event: $error"));
}
