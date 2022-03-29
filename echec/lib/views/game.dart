import 'dart:async';
import 'package:echec/models/game/affichage.dart';
import 'package:echec/models/game/case.dart';
import 'package:echec/models/game/echec.dart';
import 'package:echec/models/game/piece_echec.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  int temp;

  Game({Key? key, required this.temp}) : super(key: key);

  @override
  _GameState createState() => _GameState(temp, temp);
}

class _GameState extends State<Game> {
  bool partieEnCours = true;
  String texte = "test";
  Echec _partie = Echec();
  bool afficheCoupPossible = false;
  List<int> pieceEnMouvement = [0, 0];
  bool _retournePlateau = false;
  late Timer _timerBlanc;
  int _tempBlanc = 90;
  late Timer _timerNoir;
  int _tempNoir = 90;

  _GameState(this._tempBlanc, this._tempNoir);

  void eteindTimers() {
    try {
      stopTimer('blanc');
    } catch (e) {}
    try {
      stopTimer('noir');
    } catch (e) {}
  }

  String afficheTimer(int temp) {
    if (temp == -999) {
      return "";
    }
    int minutes = 0;
    String affichageMinute = "";
    String affichageSecondes;
    while (temp > 59) {
      minutes++;
      temp -= 60;
    }
    if (minutes < 10) {
      affichageMinute = "0" + minutes.toString();
    } else {
      affichageMinute = minutes.toString();
    }
    if (temp < 10) {
      affichageSecondes = "0" + temp.toString();
    } else {
      affichageSecondes = temp.toString();
    }
    return affichageMinute + " : " + affichageSecondes;
  }

  void stopTimer(String couleur) {
    if (couleur == 'blanc') {
      _timerBlanc.cancel();
    } else {
      _timerNoir.cancel();
    }
  }

  void startTimer(String couleur) {
    if (couleur == 'blanc') {
      _timerBlanc = Timer.periodic(
          Duration(seconds: 1),
          (_) => {
                setState(() {
                  if (_tempBlanc < 1) {
                    texte = Affichage.afficheGagnant('noir') + " au temps";
                    buildAlert(context);
                    this.partieEnCours = false;
                    _timerBlanc.cancel();
                  } else {
                    _tempBlanc--;
                  }
                })
              });
    } else {
      _timerNoir = Timer.periodic(
          Duration(seconds: 1),
          (_) => {
                setState(() {
                  if (_tempNoir < 1) {
                    texte = Affichage.afficheGagnant('blanc') + " au temps";
                    buildAlert(context);
                    this.partieEnCours = false;
                    _timerNoir.cancel();
                  } else {
                    _tempNoir--;
                  }
                })
              });
    }
  }

  @override
  void initState() {
    if (_tempBlanc != -999) {
      startTimer('blanc');
    }
    super.initState();
  }

  @override
  void dispose() {
    eteindTimers();
    super.dispose();
  }

  Image affichePrise(int index, String couleur) {
    PieceEchec laPiece;
    if (couleur == "blanc") {
      laPiece = this._partie.getPriseBlanc()[index];
    } else {
      laPiece = this._partie.getPriseNoir()[index];
    }
    return Image(
        image: AssetImage(Affichage.donneLien(laPiece)), height: 20, width: 20);
  }

  Container? buildCoupPossible(x, y) {
    Container? coupPossible = null;
    if (_partie.peutJouer(pieceEnMouvement[0], pieceEnMouvement[1], x, y) &&
        afficheCoupPossible) {
      coupPossible = Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: Color.fromARGB(255, 159, 75, 225),
        ),
        height: 18,
        width: 18,
      );
    }
    return coupPossible;
  }

  Widget? buildPiece(int x, int y) {
    Color? couleur = null;
    PieceEchec? laPiece =
        this._partie.getPlateau().getPlateau()[y][x].getPiece();
    Case laCase = this._partie.getPlateau().getPlateau()[y][x];
    Widget? piece = null;
    if (laPiece != null) {
      if (_partie.verifieCouleurCase(_partie.getJoueur(), x, y) &&
          partieEnCours) {
        piece = Draggable<Case>(
          data: laCase,
          child: Image(
            image: AssetImage(Affichage.donneLien(laPiece)),
            height: 33,
            width: 33,
          ),
          feedback: Image(
            image: AssetImage(Affichage.donneLien(laPiece)),
            height: 33,
            width: 33,
          ),
          onDragEnd: (details) {
            setState(() {
              afficheCoupPossible = false;
            });
          },
          onDragStarted: () {
            setState(() {
              afficheCoupPossible = true;
              pieceEnMouvement[0] = x;
              pieceEnMouvement[1] = y;
            });
          },
          childWhenDragging: Container(),
        );
      } else {
        piece = Container(
            height: 33,
            width: 33,
            alignment: Alignment.center,
            foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage(Affichage.donneLien(laPiece)))),
            child: buildCoupPossible(x, y));
      }
    } else {
      piece = Container(
          alignment: Alignment.center, child: buildCoupPossible(x, y));
    }
    return piece;
  }

  void relancePartie() {
    setState(() {
      this._partie = new Echec();
      this.partieEnCours = true;
    });
  }

  buildAlert(BuildContext context) {
    return showDialog(
        barrierColor: null,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 4, 0, 51),
            title: Text(texte,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'uni-sans'),
                textAlign: TextAlign.center),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        relancePartie();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Rejouer",
                        style: TextStyle(fontFamily: 'uni-sans'),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 159, 75, 225))),
                ],
              )
            ],
          );
        });
  }

  buildAlertLeave(BuildContext context) {
    return showDialog(
        barrierColor: null,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 4, 0, 51),
            title: const Text('Voulez vous vraiment quitter la partie ?',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'uni-sans'),
                textAlign: TextAlign.center),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        eteindTimers();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Oui",
                        style: TextStyle(fontFamily: 'uni-sans'),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 159, 75, 225))),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Non",
                        style: TextStyle(fontFamily: 'uni-sans'),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 159, 75, 225))),
                ],
              )
            ],
          );
        });
  }

  DragTarget buildContainer(int x, int y) {
    Color couleur = Color.fromARGB(255, 178, 237, 211);
    if ((x + y) % 2 == 1) {
      couleur = Color.fromARGB(255, 75, 225, 144);
    }
    if (_retournePlateau) {
      x = 7 - x;
      y = 7 - y;
    }
    return DragTarget<Case>(
      builder: (context, data, rejectedData) {
        return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: couleur),
              color: couleur,
            ),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: buildPiece(x, y));
      },
      onWillAccept: (data) {
        bool verif = true;
        if (!this.partieEnCours) {
          verif = false;
        } else if (!this._partie.verifieCouleurCase(
            this._partie.getJoueur(), data?.getCoordX(), data?.getCoordY())) {
          verif = false;
        } else if (!this
            ._partie
            .peutJouer(data?.getCoordX(), data?.getCoordY(), x, y)) {
          verif = false;
        }
        return verif;
      },
      onAccept: (data) {
        if (_tempBlanc != -999) {
          stopTimer(this._partie.getJoueur());
        }
        this._partie.majPlateau(data.getCoordX(), data.getCoordY(), x, y);
        if (this._partie.estMath("noir")) {
          this.partieEnCours = false;
          texte = Affichage.afficheGagnant("blanc");
          buildAlert(context);
        } else if (this._partie.estMath("blanc")) {
          this.partieEnCours = false;
          texte = Affichage.afficheGagnant("noir");
          buildAlert(context);
        } else if (_partie.checkNul()) {
          this.partieEnCours = false;
          texte = Affichage.afficheGagnant("nul");
          buildAlert(context);
        }
        if (_tempBlanc != -999) {
          setState(() {
            startTimer(this._partie.getJoueur());
          });
        }
      },
    );
  }

  @override
  onWillPop() async {
    Navigator.pop(context, "Result!");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          buildAlertLeave(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 4, 0, 51),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 4, 0, 51),
            centerTitle: true,
            title: const Text(
              'Blitz',
              style: TextStyle(
                  fontFamily: 'uni-sans', fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                          ),
                          ...List.generate(_partie.getPriseNoir().length,
                              (x) => affichePrise(x, "noir"))
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Joueur 2',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'uni-sans'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            afficheTimer(_tempNoir),
                            style: const TextStyle(
                                fontFamily: 'uni-sans',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 320,
                    height: 320,
                    foregroundDecoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        children: List.generate(
                          8,
                          (y) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(8, (x) => buildContainer(x, y)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            afficheTimer(_tempBlanc),
                            style: const TextStyle(
                                fontFamily: 'uni-sans',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Joueur 1',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'uni-sans'),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                          height: 20,
                        ),
                        ...List.generate(_partie.getPriseBlanc().length,
                            (x) => affichePrise(x, "blanc"))
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 159, 75, 225),
                              borderRadius: BorderRadius.circular(10)),
                          width: 40,
                          height: 40,
                          child: IconButton(
                            splashRadius: 1,
                            color: Colors.white,
                            icon: Icon(Icons.flag),
                            onPressed: () => {},
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 159, 75, 225),
                              borderRadius: BorderRadius.circular(10)),
                          width: 40,
                          height: 40,
                          child: IconButton(
                            splashRadius: 1,
                            color: Colors.white,
                            icon: Icon(Icons.rotate_left),
                            onPressed: () => {
                              setState(() {
                                this._retournePlateau = !_retournePlateau;
                              })
                            },
                          ))
                    ],
                  ),
                ]),
          ),
        ));
  }
}
