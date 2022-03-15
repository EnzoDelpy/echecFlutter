import 'piece_echec.dart';
import 'plateau.dart';

class Cavalier extends PieceEchec {
  Cavalier(String couleur) {
    super.setCouleur(couleur);
  }

  @override
  bool deplacement(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (checkGauche(plateau, xD, yD, xA, yA) ||
        checkBas(plateau, xD, yD, xA, yA) ||
        checkDroite(plateau, xD, yD, xA, yA) ||
        checkHaut(plateau, xD, yD, xA, yA)) {
      deplacement = true;
    }
    return deplacement;
  }

  bool checkGauche(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (xD > 1) {
      if (yD > 0) {
        if (plateau.getPlateau()[yD - 1][xD - 2].getPiece() == null) {
          if ((yD - 1) == yA && (xD - 2) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD - 1][xD - 2].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD - 1) == yA && (xD - 2) == xA) {
              deplacement = true;
            }
          }
        }
      }
      if (yD < 7) {
        if (plateau.getPlateau()[yD + 1][xD - 2].getPiece() == null) {
          if ((yD + 1) == yA && (xD - 2) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD + 1][xD - 2].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD + 1) == yA && (xD - 2) == xA) {
              deplacement = true;
            }
          }
        }
      }
    }
    return deplacement;
  }

  bool checkHaut(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (yD > 1) {
      if (xD > 0) {
        if (plateau.getPlateau()[yD - 2][xD - 1].getPiece() == null) {
          if ((yD - 2) == yA && (xD - 1) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD - 2][xD - 1].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD - 2) == yA && (xD - 1) == xA) {
              deplacement = true;
            }
          }
        }
      }
      if (xD < 7) {
        if (plateau.getPlateau()[yD - 2][xD + 1].getPiece() == null) {
          if ((yD - 2) == yA && (xD + 1) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD - 2][xD + 1].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD - 2) == yA && (xD + 1) == xA) {
              deplacement = true;
            }
          }
        }
      }
    }
    return deplacement;
  }

  bool checkDroite(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (xD < 6) {
      if (yD > 0) {
        if (plateau.getPlateau()[yD - 1][xD + 2].getPiece() == null) {
          if ((yD - 1) == yA && (xD + 2) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD - 1][xD + 2].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD - 1) == yA && (xD + 2) == xA) {
              deplacement = true;
            }
          }
        }
      }
      if (yD < 6) {
        if (plateau.getPlateau()[yD + 1][xD + 2].getPiece() == null) {
          if ((yD + 1) == yA && (xD + 2) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD + 1][xD + 2].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD + 1) == yA && (xD + 2) == xA) {
              deplacement = true;
            }
          }
        }
      }
    }
    return deplacement;
  }

  bool checkBas(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (yD < 6) {
      if (xD > 0) {
        if (plateau.getPlateau()[yD + 2][xD - 1].getPiece() == null) {
          if ((yD + 2) == yA && (xD - 1) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD + 2][xD - 1].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD + 2) == yA && (xD - 1) == xA) {
              deplacement = true;
            }
          }
        }
      }
      if (xD < 7) {
        if (plateau.getPlateau()[yD + 2][xD + 1].getPiece() == null) {
          if ((yD + 2) == yA && (xD + 1) == xA) {
            deplacement = true;
          }
        } else {
          if (plateau.getPlateau()[yD + 2][xD + 1].getPiece()?.getCouleur() !=
              this.getCouleur()) {
            if ((yD + 2) == yA && (xD + 1) == xA) {
              deplacement = true;
            }
          }
        }
      }
    }
    return deplacement;
  }

  @override
  bool prise(Plateau plateau, xD, yD, xA, yA) {
    return deplacement(plateau, xD, yD, xA, yA);
  }
}
