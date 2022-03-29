import 'package:echec/views/menu_pages/home_page.dart';
import 'package:echec/views/menu_pages/profile_page.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  int currentIndex = 0;
  final screens = const [HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 0, 51),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        iconSize: 40,
        unselectedLabelStyle:
            TextStyle(fontFamily: 'uni-sans', fontWeight: FontWeight.bold),
        selectedLabelStyle:
            TextStyle(fontFamily: 'uni-sans', fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 159, 75, 225),
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset), label: 'Jouer'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil')
        ],
      ),
    );
  }
}
