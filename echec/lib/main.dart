import 'package:echec/affichage.dart';
import 'package:echec/case.dart';
import 'package:echec/echec.dart';
import 'package:echec/piece_echec.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool partieEnCours = true;
  String texte = "test";
  Echec _partie = Echec();
  bool afficheCoupPossible = false;
  List<int> pieceEnMouvement = [0, 0];

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
        height: 36,
        width: 36,
        color: Colors.green,
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
      if (_partie.verifieCouleurCase(_partie.getJoueur(), x, y)) {
        piece = Draggable<Case>(
          data: laCase,
          child: Image(
            image: AssetImage(Affichage.donneLien(laPiece)),
            height: 43,
            width: 43,
          ),
          feedback: Image(
            image: AssetImage(Affichage.donneLien(laPiece)),
            height: 43,
            width: 43,
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
            backgroundColor: Color.fromARGB(255, 31, 30, 27),
            title: Text(texte,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      child: Text("Rejouer"),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 254, 206, 158))),
                ],
              )
            ],
          );
        });
  }

  DragTarget buildContainer(int x, int y) {
    Color couleur = Color.fromARGB(255, 254, 206, 158);
    if ((x + y) % 2 == 1) {
      couleur = Color.fromARGB(255, 209, 139, 70);
    }
    return DragTarget<Case>(
      builder: (context, data, rejectedData) {
        return Container(
            color: couleur,
            height: 43,
            width: 43,
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
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 37, 34),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 30, 27),
        centerTitle: true,
        title: Text('Echec'),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20,
              ),
              ...List.generate(
                  _partie.getPriseNoir().length, (x) => affichePrise(x, "noir"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
              Text(
                'Joueur2',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0))
            ],
          ),
          Container(
            child: Column(
              children: List.generate(
                8,
                (y) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(8, (x) => buildContainer(x, y)),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
              Text(
                'Joueur1',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: 20,
            ),
            ...List.generate(
                _partie.getPriseBlanc().length, (x) => affichePrise(x, "blanc"))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Affichage.afficheTour(_partie),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
