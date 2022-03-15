import 'dart:developer';

import 'package:echec/dame.dart';
import 'package:echec/fou.dart';
import 'package:echec/pion.dart';
import 'package:echec/tour.dart';
import 'package:collection/collection.dart';
import 'case.dart';
import 'piece_echec.dart';
import 'plateau.dart';
import 'roi.dart';

class Echec {
  int _tour = 1;
  Plateau _plateau = Plateau.depart();
  List<Case> _pieceBlanche = [];
  List<Case> _pieceNoire = [];
  List<bool> rockBlanc = [true, true];
  List<bool> rockNoir = [true, true];
  List<PieceEchec> priseNoir = [];
  List<PieceEchec> priseBlanc = [];

  Echec();

  Echec.test(this._plateau);

  void setPriseNoir(priseNoir) {
    this.priseNoir = priseNoir;
  }

  void setPriseBlanc(priseBlanc) {
    this.priseBlanc = priseBlanc;
  }

  List<PieceEchec> getPriseNoir() {
    return this.priseNoir;
  }

  List<PieceEchec> getPriseBlanc() {
    return this.priseBlanc;
  }

  void setTour(int tour) {
    this._tour = tour;
  }

  void setPlateau(Plateau plateau) {
    this._plateau = plateau;
  }

  int getTour() {
    return this._tour;
  }

  Plateau getPlateau() {
    return this._plateau;
  }

  void setPieceNoire(List<Case> pieceNoire) {
    this._pieceNoire = pieceNoire;
  }

  void setPieceBlanche(List<Case> pieceBlanche) {
    this._pieceBlanche = pieceBlanche;
  }

  List<Case> getPieceNoire() {
    return this._pieceNoire;
  }

  List<Case> getPieceBlance() {
    return this._pieceBlanche;
  }

  void majPiece() {
    _pieceBlanche = [];
    _pieceNoire = [];
    for (List<Case> elt in this._plateau.getPlateau()) {
      for (Case elt2 in elt) {
        if (elt2.getPiece() != null) {
          if (elt2.getPiece()?.getCouleur() == "noir") {
            this._pieceNoire.add(elt2);
          } else {
            this._pieceBlanche.add(elt2);
          }
        }
      }
    }
  }

  Case getCaseRoi(String couleur) {
    Case caseRoi = Case(0, 0, Roi(couleur));
    for (List<Case> elt in this._plateau.getPlateau()) {
      for (Case elt2 in elt) {
        if (elt2.getPiece() != null) {
          if (elt2.getPiece()?.getCouleur() == couleur &&
              elt2.getPiece() is Roi) {
            caseRoi = elt2;
          }
        }
      }
    }
    return caseRoi;
  }

  bool estEchec(String couleur) {
    majPiece();
    bool echec = false;
    if (couleur == "noir") {
      for (Case elt in this._pieceBlanche) {
        if (elt.getPiece()?.prise(
                this._plateau,
                elt.getCoordX(),
                elt.getCoordY(),
                getCaseRoi(couleur).getCoordX(),
                getCaseRoi(couleur).getCoordY()) ==
            true) {
          echec = true;
        }
      }
    } else {
      for (Case elt in this._pieceNoire) {
        if (elt.getPiece()?.prise(
                this._plateau,
                elt.getCoordX(),
                elt.getCoordY(),
                getCaseRoi(couleur).getCoordX(),
                getCaseRoi(couleur).getCoordY()) ==
            true) {
          echec = true;
        }
      }
    }
    return echec;
  }

  bool coordEchec(x, y, couleur) {
    majPiece();
    bool echec = false;
    if (couleur == "noir") {
      for (Case elt in this._pieceBlanche) {
        if (elt.getPiece()?.prise(
                this._plateau, elt.getCoordX(), elt.getCoordY(), x, y) ==
            true) {
          echec = true;
        }
      }
    } else {
      for (Case elt in this._pieceNoire) {
        if (elt.getPiece()?.prise(
                this._plateau, elt.getCoordX(), elt.getCoordY(), x, y) ==
            true) {
          echec = true;
        }
      }
    }
    return echec;
  }

  bool peutJouer(xD, yD, xA, yA) {
    bool peutJouer = true;
    String couleur = "blanc";
    if (this._plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() == "noir") {
      couleur = "noir";
    }

    if (this
            ._plateau
            .getPlateau()[yD][xD]
            .getPiece()
            ?.deplacement(this._plateau, xD, yD, xA, yA) ==
        true) {
      Echec partieTest = Echec.test(this._plateau.dupliqueGrille());
      partieTest.getPlateau().deplace(xD, yD, xA, yA);
      partieTest.majPiece();
      if (partieTest.estEchec(couleur)) {
        peutJouer = false;
      }
    } else if (peutRock(xD, yD, xA, yA)) {
      peutJouer = true;
    } else {
      peutJouer = false;
    }
    return peutJouer;
  }

  bool verifieCouleurCase(String couleur, x, y) {
    bool estBonne = false;
    if (this._plateau.getPlateau()[y][x].getPiece() != null) {
      if (this._plateau.getPlateau()[y][x].getPiece()?.getCouleur() ==
          couleur) {
        estBonne = true;
      }
    }
    return estBonne;
  }

  String getJoueur() {
    String joueur = "";
    if ((this._tour % 2) == 1) {
      joueur = "blanc";
    } else {
      joueur = "noir";
    }
    return joueur;
  }

  void augmenteTour() {
    this._tour++;
  }

  bool estMath(String couleur) {
    bool math = estEchec(couleur);
    majPiece();
    for (int k = 0; k < 8; k++) {
      for (int i = 0; i < 8; i++) {
        if (couleur == "blanc") {
          for (Case elt in _pieceBlanche) {
            if (elt.getPiece()?.deplacement(
                    this._plateau, elt.getCoordX(), elt.getCoordY(), i, k) ==
                true) {
              Echec partieTest = Echec.test(this._plateau.dupliqueGrille());
              partieTest.majPiece();
              partieTest
                  .getPlateau()
                  .deplace(elt.getCoordX(), elt.getCoordY(), i, k);
              if (partieTest.estEchec(couleur) == false) {
                math = false;
              }
            }
          }
        } else {
          for (Case elt in _pieceNoire) {
            if (elt.getPiece()?.deplacement(
                    this._plateau, elt.getCoordX(), elt.getCoordY(), i, k) ==
                true) {
              Echec partieTest = Echec.test(this._plateau.dupliqueGrille());
              partieTest
                  .getPlateau()
                  .deplace(elt.getCoordX(), elt.getCoordY(), i, k);
              if (partieTest.estEchec(couleur) == false) {
                math = false;
              }
            }
          }
        }
      }
    }
    return math;
  }

  bool estPat(String couleur) {
    bool pat = true;
    majPiece();
    for (int k = 0; k < 8; k++) {
      for (int i = 0; i < 8; i++) {
        if (couleur == "blanc") {
          for (Case elt in _pieceBlanche) {
            if (elt.getPiece()?.deplacement(
                    this._plateau, elt.getCoordX(), elt.getCoordY(), i, k) ==
                true) {
              Echec partieTest = Echec.test(this._plateau.dupliqueGrille());
              partieTest.majPiece();
              partieTest
                  .getPlateau()
                  .deplace(elt.getCoordX(), elt.getCoordY(), i, k);
              if (partieTest.estEchec(couleur) == false) {
                pat = false;
              }
            }
          }
        } else {
          for (Case elt in _pieceNoire) {
            if (elt.getPiece()?.deplacement(
                    this._plateau, elt.getCoordX(), elt.getCoordY(), i, k) ==
                true) {
              Echec partieTest = Echec.test(this._plateau.dupliqueGrille());
              partieTest
                  .getPlateau()
                  .deplace(elt.getCoordX(), elt.getCoordY(), i, k);
              if (partieTest.estEchec(couleur) == false) {
                pat = false;
              }
            }
          }
        }
      }
    }
    return pat;
  }

  void checkPromotion() {
    majPiece();
    for (Case elt in this._pieceNoire) {
      if (elt.getPiece() is Pion && elt.getCoordY() == 7) {
        elt.setPiece(new Dame("noir"));
      }
    }
    for (Case elt in this._pieceBlanche) {
      if (elt.getPiece() is Pion && elt.getCoordY() == 0) {
        elt.setPiece(new Dame("blanc"));
      }
    }
  }

  bool coordEstVide(x, y) {
    bool estVide = false;
    if (this._plateau.getPlateau()[y][x].getPiece() == null) {
      estVide = true;
    }
    return estVide;
  }

  void majRock() {
    if (this.getCaseRoi("blanc").getCoordX() != 4 ||
        this.getCaseRoi("blanc").getCoordY() != 7) {
      this.rockBlanc[0] = false;
      this.rockBlanc[1] = false;
    } else if (this._plateau.getPlateau()[7][0].getPiece() is Tour == false) {
      this.rockBlanc[0] = false;
    } else if (this._plateau.getPlateau()[7][7].getPiece() is Tour == false) {
      this.rockBlanc[1] = false;
    }
    if (this.getCaseRoi("noir").getCoordX() != 4 ||
        this.getCaseRoi("noir").getCoordY() != 0) {
      this.rockNoir[0] = false;
      this.rockNoir[1] = false;
    } else if (this._plateau.getPlateau()[0][0].getPiece() is Tour == false) {
      this.rockNoir[0] = false;
    } else if (this._plateau.getPlateau()[0][7].getPiece() is Tour == false) {
      this.rockNoir[1] = false;
    }
  }

  bool peutRock(xD, yD, xA, yA) {
    bool deplacement = false;
    PieceEchec? laPiece = this._plateau.getPlateau()[yD][xD].getPiece();
    if (laPiece is Roi) {
      if (laPiece.getCouleur() == "blanc") {
        if (this.rockBlanc[0] == true &&
            xA == 2 &&
            yA == 7 &&
            !estEchec("blanc")) {
          if (!coordEchec(3, 7, "blanc") &&
              !coordEchec(2, 7, "blanc") &&
              coordEstVide(1, 7) &&
              coordEstVide(2, 7) &&
              coordEstVide(3, 7)) {
            deplacement = true;
          }
        } else if (this.rockBlanc[1] == true &&
            xA == 6 &&
            yA == 7 &&
            !estEchec("blanc")) {
          if (!coordEchec(5, 7, "blanc") &&
              !coordEchec(6, 7, "blanc") &&
              coordEstVide(5, 7) &&
              coordEstVide(6, 7)) {
            deplacement = true;
          }
        }
      } else {
        if (this.rockNoir[0] == true &&
            xA == 2 &&
            yA == 0 &&
            !estEchec("noir")) {
          if (!coordEchec(3, 0, "noir") &&
              !coordEchec(2, 0, "noir") &&
              coordEstVide(1, 0) &&
              coordEstVide(2, 0) &&
              coordEstVide(3, 0)) {
            deplacement = true;
          }
        } else if (this.rockNoir[1] == true &&
            xA == 6 &&
            yA == 0 &&
            !estEchec("noir")) {
          if (!coordEchec(5, 0, "noir") &&
              !coordEchec(6, 0, "noir") &&
              coordEstVide(5, 0) &&
              coordEstVide(6, 0)) {
            deplacement = true;
          }
        }
      }
    }
    return deplacement;
  }

  void majPlateau(xD, yD, xA, yA) {
    if (peutRock(xD, yD, xA, yA)) {
      this._plateau.deplace(xD, yD, xA, yA);
      if (xA == 2) {
        if (yA == 0) {
          this._plateau.deplace(0, 0, 3, 0);
        } else {
          this._plateau.deplace(0, 7, 3, 7);
        }
      } else {
        if (yA == 0) {
          this._plateau.deplace(7, 0, 5, 0);
        } else {
          this._plateau.deplace(7, 7, 5, 7);
        }
      }
    } else {
      checkPriseEnPassant(xD, yD, xA, yA);
      PieceEchec? caseArrive = this._plateau.getPlateau()[yA][xA].getPiece();
      if (caseArrive != null) {
        if (caseArrive.getCouleur() == "noir") {
          this.priseBlanc.add(caseArrive);
        } else {
          this.priseNoir.add(caseArrive);
        }
      }
      this._plateau.deplace(xD, yD, xA, yA);
    }
    augmenteTour();
    checkPromotion();
    majRock();
    this._plateau.getHistoriqueCoup().add([xD, yD, xA, yA]);
    this
        ._plateau
        .getHistoriquePlateau()
        .add(this._plateau.dupliqueGrille().getPlateau());
  }

  void checkPriseEnPassant(xD, yD, xA, yA) {
    PieceEchec? piece = this._plateau.getPlateau()[yD][xD].getPiece();
    if (piece is Pion) {
      if (piece.checkPriseEnPassant(this._plateau, xD, yD, xA, yA)) {
        int xR = this._plateau.getHistoriqueCoup()[
            this._plateau.getHistoriqueCoup().length - 1][2];
        int yR = this._plateau.getHistoriqueCoup()[
            this._plateau.getHistoriqueCoup().length - 1][3];
        PieceEchec? caseArrive = this._plateau.getPlateau()[yR][xR].getPiece();
        if (caseArrive != null) {
          if (caseArrive.getCouleur() == "noir") {
            this.priseBlanc.add(caseArrive);
          } else {
            this.priseNoir.add(caseArrive);
          }
        }
        this._plateau.getPlateau()[yR][xR].setPiece(null);
      }
    }
  }

  bool memePlateau(List<List<Case>> plateau1, List<List<Case>> plateau2) {
    for (int k = 0; k < 8; k++) {
      for (int i = 0; i < 8; i++) {
        if (plateau1[k][i].getPiece() != null &&
            plateau2[k][i].getPiece() != null) {
          if (plateau1[k][i].getPiece()?.getCouleur() !=
              plateau2[k][i].getPiece()?.getCouleur()) {
            return false;
          }
        } else if (plateau1[k][i].getPiece() != null ||
            plateau2[k][i].getPiece() != null) {
          return false;
        }
      }
    }
    return true;
  }

  bool coupPerpetuel() {
    bool perpetuel = false;
    for (List<List<Case>> elt1 in this._plateau.getHistoriquePlateau()) {
      int compteur = 0;
      for (List<List<Case>> elt2 in this._plateau.getHistoriquePlateau()) {
        if (memePlateau(elt1, elt2)) {
          compteur++;
        }
        if (compteur > 2) {
          perpetuel = true;
        }
      }
    }
    return perpetuel;
  }

  bool pieceInsuffisante() {
    bool insufisant = false;
    if (this._pieceBlanche.length + this._pieceNoire.length < 4) {
      insufisant = true;
      for (Case elt in this._pieceBlanche) {
        if (elt.getPiece() is Dame ||
            elt.getPiece() is Tour ||
            elt.getPiece() is Pion) {
          insufisant = false;
        }
      }
      for (Case elt in this._pieceNoire) {
        if (elt.getPiece() is Dame ||
            elt.getPiece() is Tour ||
            elt.getPiece() is Pion) {
          insufisant = false;
        }
      }
    }
    return insufisant;
  }

  bool checkNul() {
    bool nul = false;
    if (estPat("noir") || estPat("blanc")) {
      nul = true;
    }
    if (coupPerpetuel()) {
      nul = true;
    }
    if (pieceInsuffisante()) {
      nul = true;
    }
    return nul;
  }
}
