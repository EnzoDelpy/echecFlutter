import 'package:echec/views/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 0, 51),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Jouer',
          style: TextStyle(fontFamily: 'uni-sans'),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 4, 0, 51),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Game(
                                  temp: -999,
                                )));
                  },
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 158, 74, 225),
                          Color.fromARGB(255, 32, 52, 236),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 32, 52, 236).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/pion_menu.png'),
                                              fit: BoxFit.fill)),
                                      height: 96,
                                      width: 68,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(255, 130, 69, 228)
                                                .withOpacity(0.0),
                                            Color.fromARGB(255, 76, 59, 232)
                                                .withOpacity(0.8),
                                          ],
                                        ),
                                      ),
                                      height: 96,
                                      width: 68,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Classique',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'uni-sans',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                                width: 12,
                              )
                            ],
                          ),
                          Text('Pas de limite de temps',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'uni-sans',
                                  fontSize: 10)),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Game(
                                  temp: 10,
                                )));
                  },
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 74, 224, 143),
                          Color.fromARGB(255, 32, 52, 236),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 32, 52, 236).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/pion_menu.png'),
                                              fit: BoxFit.fill)),
                                      height: 96,
                                      width: 68,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(255, 66, 193, 160)
                                                .withOpacity(0.0),
                                            Color.fromARGB(255, 45, 105, 207)
                                                .withOpacity(0.8),
                                          ],
                                        ),
                                      ),
                                      height: 96,
                                      width: 68,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Bullet',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'uni-sans',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                                width: 21,
                              )
                            ],
                          ),
                          Text('1  minute par joueur',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'uni-sans',
                                  fontSize: 10)),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Game(
                                  temp: 300,
                                )));
                  },
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 225, 75, 138),
                          Color.fromARGB(255, 32, 52, 236),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 32, 52, 236).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/pion_menu.png'),
                                              fit: BoxFit.fill)),
                                      height: 96,
                                      width: 68,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(255, 187, 70, 157)
                                                .withOpacity(0.0),
                                            Color.fromARGB(255, 92, 59, 206)
                                                .withOpacity(0.8),
                                          ],
                                        ),
                                      ),
                                      height: 96,
                                      width: 68,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Blitz',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'uni-sans',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                                width: 45,
                              )
                            ],
                          ),
                          Text('5 minutes par joueur',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'uni-sans',
                                  fontSize: 10)),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Game(
                                  temp: 600,
                                )));
                  },
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 247, 155, 72),
                          Color.fromARGB(255, 32, 52, 236),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 32, 52, 236).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/pion_menu.png'),
                                              fit: BoxFit.fill)),
                                      height: 96,
                                      width: 68,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(255, 205, 135, 104)
                                                .withOpacity(0.0),
                                            Color.fromARGB(255, 97, 83, 186)
                                                .withOpacity(0.8),
                                          ],
                                        ),
                                      ),
                                      height: 96,
                                      width: 68,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Rapide',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'uni-sans',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                                width: 30,
                              )
                            ],
                          ),
                          Text('10 minutes par joueur',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'uni-sans',
                                  fontSize: 10)),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
