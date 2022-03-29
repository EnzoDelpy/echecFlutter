import 'package:echec/models/game/piece_echec.dart';
import 'echec.dart';

class Affichage {
  static String donneLien(PieceEchec piece) {
    return "assets/" + piece.getNom() + "_" + piece.getCouleur() + ".png";
  }

  static String afficheTour(Echec partie) {
    return "Tour des " + partie.getJoueur() + "s";
  }

  static String afficheGagnant(String couleur) {
    String affichage = "";
    if (couleur == "noir" || couleur == "blanc") {
      affichage = "Les " + couleur + "s gagnent la partie";
    } else {
      affichage = "Match nul";
    }
    return affichage;
  }
}
