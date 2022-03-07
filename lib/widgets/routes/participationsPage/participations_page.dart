import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../eventList/event_list.dart';
import '../profilePage/profile_page.dart';

class ParticipationPage extends StatefulWidget {
  const ParticipationPage({Key? key}) : super(key: key);

  @override
  State<ParticipationPage> createState() => _ParticipationPage();
}

class _ParticipationPage extends State<ParticipationPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const EventList(),
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfilePage(),
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    final CollectionReference _events = FirebaseFirestore.instance
        .collection('User')
        .doc(result!.uid)
        .collection('MyEvent');

    return StreamBuilder(
        stream: _events.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> Streamsnapshot) {
          if (Streamsnapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (Streamsnapshot.hasData) {
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
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          automaticallyImplyLeading: false,
                          centerTitle: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              profileImg(),
                              const Text(
                                'Accueil',
                                style: TextStyle(
                                    fontSize: 42,
                                    fontFamily: 'Quigleyw',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 40,
                                ),
                                padding: const EdgeInsets.all(3),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                body: ListView.builder(
                    itemCount: Streamsnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return MyEventParticipation(
                        idEventParticipation:
                            Streamsnapshot.data!.docs[index].id.toString(),
                      );

                      /*ListTile(
                      title: Text(data['full_name']),
                      subtitle: Text(data['company']),
                    );*/
                    }

                    /*const SizedBox(
                    height: 12,
                  ),*/

                    // ---------- Container De l'event ----------
                    //
                    ),

                //---------- Le footer de l'appli ----------
                //
                //
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 2.0,
                  unselectedItemColor: const Color.fromARGB(255, 43, 42, 42),
                  backgroundColor: Colors.white,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: 'Accueil',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.check_circle,
                      ),
                      label: 'Mes participations',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle_rounded,
                      ),
                      label: 'Mon compte',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: const Color.fromRGBO(13, 19, 132, 1.0),
                  onTap: _onItemTapped,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class MyEventParticipation extends StatelessWidget {
  String? idEventParticipation;
  MyEventParticipation({Key? key, this.idEventParticipation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference _event = FirebaseFirestore.instance.collection('Event');
    return FutureBuilder<DocumentSnapshot>(
        future: _event.doc(idEventParticipation).get(),
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
              height: 252,
              margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20),
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 2,
              ),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 42, 42, 43),
                      blurRadius: 4,
                      offset: Offset(4, 8),
                    )
                  ]),
              child: Column(children: [
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.perm_contact_calendar_outlined,
                          color: Color.fromARGB(255, 39, 39, 39),
                        ),
                        Text(
                          "${data['Title']}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 39, 39, 39),
                          ),
                        ),
                      ],
                    ),

                    // ---------- Container des informations de l'event ----------
                    //
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(children: [
                            const Icon(Icons.calendar_today),
                            Text(
                              " ${data['Date'].toDate().toString().split(" ")[0]}",
                              style: const TextStyle(fontSize: 16),
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.people_alt),
                              Text(" 0/${data['PeopleLimit']}",
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.place),
                              Text("${data['Location']}",
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: const StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    text: "${data['Description']}"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/details',
                                    arguments: idEventParticipation.toString(),
                                  );
                                },
                                icon: const Icon(Icons.more),
                                label: const Text("Plus d'infos"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(140, 140, 140, 1),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              _myEvent(
                                  idEvent: idEventParticipation.toString()),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ]),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              return NotInscriptionButton(context);
            } else {
              return InscriptionButton(context);
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Widget NotInscriptionButton(context) {
  return TextButton.icon(
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Désinscription'),
        content: const Text('Quitter cet événement ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Oui...'),
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

Widget InscriptionButton(context) {
  return TextButton.icon(
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Désinscription'),
        content: const Text('Quitter cet événement ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Oui...'),
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
    label: const Text("S'inscrire'"),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 11, 151, 23),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  );
}
