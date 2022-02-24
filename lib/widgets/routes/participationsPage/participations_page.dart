import 'package:flutter/material.dart';


import '../eventDetails/event_details.dart';
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
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const ProfilePage(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ),
                              );
                            },
                            icon: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://media.discordapp.net/attachments/902535167850197022/935551661001302026/Clem.jpg?width=661&height=663"),
                              radius: 72.0,
                            )),
                      ),
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
        body: ListView(
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),

            // ---------- Container De l'event ----------
            //
            Container(
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
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.perm_contact_calendar_outlined,
                            color: Color.fromARGB(255, 39, 39, 39),
                          ),
                          Text(
                            " Brocante d'instruments",
                            style: TextStyle(
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(children: const [
                                    Icon(Icons.calendar_today_rounded),
                                    Text(
                                      " 05/03/2022",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.people_alt),
                                      Text(" 13/20",
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.place),
                                      Text(" 7 rue du bois à Montpellier",
                                          style: TextStyle(fontSize: 16)),
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
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Ceci est la description de l’événement,  il peut s’agir d’un marché de noel également...",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EventDetails()));
                                        },
                                        icon: const Icon(Icons.more),
                                        label: const Text("Plus d'infos"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(
                                                140, 140, 140, 1),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      TextButton.icon(
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            title: const Text('Désinscription'),
                                            content: const Text(
                                                'Quitter cet événement ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Oui...'),
                                                child: const Text('Oui...'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Non !'),
                                                child: const Text('Non !'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.close_rounded,
                                        ),
                                        label: const Text("Annuler"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(200, 3, 10, 1),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ],
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
}
