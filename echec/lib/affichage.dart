import 'package:echec/piece_echec.dart';

import 'case.dart';
import 'cavalier.dart';
import 'dame.dart';
import 'echec.dart';
import 'fonctions.dart';
import 'fou.dart';
import 'pion.dart';
import 'plateau.dart';
import 'roi.dart';
import 'tour.dart';

class Affichage {
  static String affichePlateau(Plateau plateau) {
    String affichage = "";
    int k = 0;
    for (List<Case> elt1 in plateau.getPlateau()) {
      affichage += "\x1B[31m" + k.toString() + "\x1B[0m";
      k++;
      for (Case elt2 in elt1) {
        affichage += caseToString(elt2);
      }
      affichage += "\n";
    }
    affichage += " ";
    for (int k = 0; k < 8; k++) {
      affichage += "\x1B[31m" + k.toString() + "\x1B[0m";
    }
    return affichage;
  }

  static String caseToString(Case element) {
    String valeur = "";
    if (element.getPiece() == null) {
      valeur = ".";
    } else if (element.getPiece() is Roi) {
      if (element.getPiece()?.getCouleur() == "noir") {
        valeur = "\x1B[30mR\x1B[0m";
      } else {
        valeur = "R";
      }
    } else if (element.getPiece() is Fou) {
      if (element.getPiece()?.getCouleur() == "noir") {
        valeur = "\x1B[30mF\x1B[0m";
      } else {
        valeur = "F";
      }
    } else if (element.getPiece() is Tour) {
      if (element.getPiece()?.getCouleur() == "noir") {
        valeur = "\x1B[30mT\x1B[0m";
      } else {
        valeur = "T";
      }
    } else if (element.getPiece() is Cavalier) {
      if (element.getPiece()?.getCouleur() == "noir") {
        valeur = "\x1B[30mC\x1B[0m";
      } else {
        valeur = "C";
      }
    } else if (element.getPiece() is Dame) {
      if (element.getPiece()?.getCouleur() == "noir") {
        valeur = "\x1B[30mD\x1B[0m";
      } else {
        valeur = "D";
      }
    } else if (element.getPiece() is Pion) {
      if (element.getPiece()?.getCouleur() == "noir") {
        valeur = "\x1B[30mP\x1B[0m";
      } else {
        valeur = "P";
      }
    }
    return valeur;
  }

  static String donneLien(PieceEchec piece) {
    return "assets/" + piece.getNom() + "_" + piece.getCouleur() + ".png";
  }

  static int choixPieceX() {
    int choix = -1;
    print("Choississez la coordonée X de la piece à jouer");
    while (choix < 0 || choix > 7) {
      choix = MesFonctions.saisirInt();
    }
    return choix;
  }

  static int choixPieceY() {
    int choix = -1;
    print("Choississez la coordonée Y de la piece à jouer");
    while (choix < 0 || choix > 7) {
      choix = MesFonctions.saisirInt();
    }
    return choix;
  }

  static int deplacePieceX() {
    int choix = -1;
    print("Choississez la coordonée X de la case d'arrivée de la piece");
    while (choix < 0 || choix > 7) {
      choix = MesFonctions.saisirInt();
    }
    return choix;
  }

  static int deplacePieceY() {
    int choix = -1;
    print("Choississez la coordonée Y de la case d'arrivée de la piece");
    while (choix < 0 || choix > 7) {
      choix = MesFonctions.saisirInt();
    }
    return choix;
  }

  static String afficheTour(Echec partie) {
    return "Tour des " + partie.getJoueur();
  }

  static String erreurDeplacement() {
    return "Déplacement impossible";
  }

  static String afficheGagnant(String couleur) {
    String affichage = "";
    if (couleur == "noir" || couleur == "blanc") {
      affichage = "Les " + couleur + " gagnent la partie";
    } else {
      affichage = "Match nul";
    }
    return affichage;
  }
}
