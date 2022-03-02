import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../eventList/event_list.dart';
import '../participationsPage/participations_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? result = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 2;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

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
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ParticipationPage(),
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('User');
    return FutureBuilder<DocumentSnapshot>(
        future: user.doc(result!.uid).get(),
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
            //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    // ---------- Bannière ---------- //
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://media.discordapp.net/attachments/902535167850197022/935552865894793236/hoymille_brocante_7.jpg?width=1178&height=662"),
                              fit: BoxFit.cover)),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        // ---------- Photo de profil ---------- //
                        child: Container(
                          alignment: const Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("${data['Picture']}"),
                            radius: 72.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    // ---------- Nom/Prénom ---------- //
                    Text(
                      "${data['FirstName']} ${data['LastName']}",
                      style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ---------- Statut ---------- //
                    Text(
                      "${data['Description']}",
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ---------- Email ---------- //
                    Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        elevation: 2.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            child: Text(
                              "${data['Email']}",
                              style: const TextStyle(
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            ))),
                    const SizedBox(
                      height: 12,
                    ),
                    // ---------- Nombre de participations ---------- //
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: const [
                                  Text(
                                    "Participations à venir :",
                                    style: TextStyle(
                                        color: Color.fromRGBO(36, 45, 165, 1),
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // ---------- Informations ---------- //
                    const Text(
                      "En cas de besoin de modification des informations ci-dessus, merci de contacter un administrateur.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              // ---------- BottomNavBar ---------- //
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
            );
          }
          return const Text("loading");
        });
  }
}
