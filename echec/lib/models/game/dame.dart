import 'piece_echec.dart';
import 'plateau.dart';

class Dame extends PieceEchec {
  Dame(String couleur) {
    super.setCouleur(couleur);
  }

  @override
  bool deplacement(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (checkHautGauche(plateau, xD, yD, xA, yA) ||
        checkHautDroite(plateau, xD, yD, xA, yA) ||
        checkBasGauche(plateau, xD, yD, xA, yA) ||
        checkBasDroite(plateau, xD, yD, xA, yA) ||
        checkGauche(plateau, xD, yD, xA, yA) ||
        checkDroite(plateau, xD, yD, xA, yA) ||
        checkBas(plateau, xD, yD, xA, yA) ||
        checkHaut(plateau, xD, yD, xA, yA)) {
      deplacement = true;
    }
    return deplacement;
  }

  bool checkHautGauche(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool hautGauche = true;
    while (xD > 0 && yD > 0 && hautGauche && !deplacement) {
      xD--;
      yD--;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        hautGauche = false;
      } else {
        hautGauche = false;
      }
    }
    return deplacement;
  }

  bool checkBasGauche(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool basGauche = true;
    while (xD > 0 && yD < 7 && basGauche && !deplacement) {
      xD--;
      yD++;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        basGauche = false;
      } else {
        basGauche = false;
      }
    }
    return deplacement;
  }

  bool checkHautDroite(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool hautDroite = true;
    while (xD < 7 && yD > 0 && hautDroite && !deplacement) {
      xD++;
      yD--;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        hautDroite = false;
      } else {
        hautDroite = false;
      }
    }
    return deplacement;
  }

  bool checkBasDroite(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool basDroite = true;
    while (xD < 7 && yD < 7 && basDroite && !deplacement) {
      xD++;
      yD++;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        basDroite = false;
      } else {
        basDroite = false;
      }
    }
    return deplacement;
  }

  bool checkGauche(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool gauche = true;
    while (xD > 0 && gauche == true && !deplacement) {
      xD--;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        gauche = false;
      } else {
        gauche = false;
      }
    }
    return deplacement;
  }

  bool checkDroite(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool droite = true;
    while (xD < 7 && droite == true && !deplacement) {
      xD++;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        droite = false;
      } else {
        droite = false;
      }
    }
    return deplacement;
  }

  bool checkHaut(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool haut = true;
    while (yD > 0 && haut == true && !deplacement) {
      yD--;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        haut = false;
      } else {
        haut = false;
      }
    }
    return deplacement;
  }

  bool checkBas(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    bool bas = true;
    while (yD < 7 && bas && !deplacement) {
      yD++;
      if (plateau.getPlateau()[yD][xD].getPiece() == null) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
      } else if (plateau.getPlateau()[yD][xD].getPiece()?.getCouleur() !=
          this.getCouleur()) {
        if (yD == yA && xA == xD) {
          deplacement = true;
        }
        bas = false;
      } else {
        bas = false;
      }
    }
    return deplacement;
  }

  @override
  bool prise(Plateau plateau, xD, yD, xA, yA) {
    return deplacement(plateau, xD, yD, xA, yA);
  }
}
