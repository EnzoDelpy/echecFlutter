import 'case.dart';
import 'cavalier.dart';
import 'dame.dart';
import 'fou.dart';
import 'pion.dart';
import 'roi.dart';
import 'tour.dart';

class Plateau {
  late List<List<Case>> _plateau;
  List<List<int>> _historiqueCoup = [];
  List<List<List<Case>>> _historiquePlateau = [];

  Plateau(this._plateau, this._historiqueCoup);

  Plateau.depart() {
    this._plateau =
        new List.generate(8, (index) => new List.empty(growable: true));
    for (int k = 0; k < 8; k++) {
      for (int i = 0; i < 8; i++) {
        this._plateau[k].add(new Case.vide(i, k));
      }
    }
    this._plateau[0][0].setPiece(new Tour("noir"));
    this._plateau[0][1].setPiece(new Cavalier("noir"));
    this._plateau[0][2].setPiece(new Fou("noir"));
    this._plateau[0][3].setPiece(new Dame("noir"));
    this._plateau[0][4].setPiece(new Roi("noir"));
    this._plateau[0][5].setPiece(new Fou("noir"));
    this._plateau[0][6].setPiece(new Cavalier("noir"));
    this._plateau[0][7].setPiece(new Tour("noir"));
    for (int k = 0; k < 8; k++) {
      this._plateau[1][k].setPiece(new Pion("noir"));
    }
    this._plateau[7][0].setPiece(new Tour("blanc"));
    this._plateau[7][1].setPiece(new Cavalier("blanc"));
    this._plateau[7][2].setPiece(new Fou("blanc"));
    this._plateau[7][3].setPiece(new Dame("blanc"));
    this._plateau[7][4].setPiece(new Roi("blanc"));
    this._plateau[7][5].setPiece(new Fou("blanc"));
    this._plateau[7][6].setPiece(new Cavalier("blanc"));
    this._plateau[7][7].setPiece(new Tour("blanc"));
    for (int k = 0; k < 8; k++) {
      this._plateau[6][k].setPiece(new Pion("blanc"));
    }
    this._historiquePlateau = [dupliqueGrille().getPlateau()];
  }

  List<List<List<Case>>> getHistoriquePlateau() {
    return this._historiquePlateau;
  }

  void setHistoriquePlateau(historiquePlateau) {
    this._historiquePlateau = historiquePlateau;
  }

  List<List<int>> getHistoriqueCoup() {
    return this._historiqueCoup;
  }

  void setHistoriqueCoup(historiqueCoup) {
    this._historiqueCoup = historiqueCoup;
  }

  List<List<Case>> getPlateau() {
    return this._plateau;
  }

  void deplace(xD, yD, xA, yA) {
    this._plateau[yA][xA].setPiece(this._plateau[yD][xD].getPiece());
    this._plateau[yD][xD].setPiece(null);
  }

  Plateau dupliqueGrille() {
    int k = 0;
    List<List<Case>> grille = [[], [], [], [], [], [], [], []];
    for (List<Case> elt1 in this._plateau) {
      for (Case elt2 in elt1) {
        grille[k]
            .add(new Case(elt2.getCoordX(), elt2.getCoordY(), elt2.getPiece()));
      }
      k++;
    }
    return Plateau(grille, this._historiqueCoup);
  }
}
