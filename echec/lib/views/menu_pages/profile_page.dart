import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 0, 51),
      appBar: AppBar(
          title: Text('Profil'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 4, 0, 51),
          elevation: 0),
      body: const Center(
        child: Text(
          'Profil',
          style: TextStyle(fontSize: 60, color: Colors.white),
        ),
      ),
    );
  }
}
