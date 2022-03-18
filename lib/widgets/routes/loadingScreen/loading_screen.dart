import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
      ),
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
}
