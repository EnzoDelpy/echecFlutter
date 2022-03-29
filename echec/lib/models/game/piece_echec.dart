import 'package:echec/models/game/cavalier.dart';
import 'package:echec/models/game/dame.dart';
import 'package:echec/models/game/fou.dart';
import 'package:echec/models/game/pion.dart';
import 'package:echec/models/game/roi.dart';
import 'package:echec/models/game/tour.dart';

import 'plateau.dart';

abstract class PieceEchec {
  late String _couleur;

  void setCouleur(couleur) {
    this._couleur = couleur;
  }

  String getCouleur() {
    return this._couleur;
  }

  String getNom() {
    String nom = "";
    if (this is Fou) {
      nom = "fou";
    } else if (this is Cavalier) {
      nom = "cavalier";
    } else if (this is Pion) {
      nom = "pion";
    } else if (this is Roi) {
      nom = "roi";
    } else if (this is Tour) {
      nom = "tour";
    } else if (this is Dame) {
      nom = "dame";
    }
    return nom;
  }

  bool deplacement(Plateau plateau, xD, yD, xA, yA);

  bool prise(Plateau plateau, xD, yD, xA, yA);
}
