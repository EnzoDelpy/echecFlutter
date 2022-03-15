import 'piece_echec.dart';
import 'plateau.dart';
import 'package:collection/collection.dart';

class Pion extends PieceEchec {
  Pion(String couleur) {
    super.setCouleur(couleur);
  }

  @override
  bool deplacement(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (checkPrise(plateau, xD, yD, xA, yA) ||
        checkAvance(plateau, xD, yD, xA, yA) ||
        checkPriseEnPassant(plateau, xD, yD, xA, yA)) {
      deplacement = true;
    }
    return deplacement;
  }

  @override
  bool prise(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (checkPrise(plateau, xD, yD, xA, yA)) {
      deplacement = true;
    }
    return deplacement;
  }

  bool checkAvance(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (this.getCouleur() == "noir") {
      if (yD < 7) {
        if (plateau.getPlateau()[yD + 1][xD].getPiece() == null) {
          if (xD == xA && (yD + 1) == yA) {
            deplacement = true;
          } else if (yD == 1) {
            if (plateau.getPlateau()[yD + 2][xD].getPiece() == null) {
              if (xD == xA && (yD + 2) == yA) {
                deplacement = true;
              }
            }
          }
        }
      }
    } else {
      if (yD > 0) {
        if (plateau.getPlateau()[yD - 1][xD].getPiece() == null) {
          if (xD == xA && (yD - 1) == yA) {
            deplacement = true;
          } else if (yD == 6) {
            if (plateau.getPlateau()[yD - 2][xD].getPiece() == null) {
              if (xD == xA && (yD - 2) == yA) {
                deplacement = true;
              }
            }
          }
        }
      }
    }
    return deplacement;
  }

  bool checkPrise(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (this.getCouleur() == "noir") {
      if (yD < 7) {
        if (xD > 0) {
          if (plateau.getPlateau()[yD + 1][xD - 1].getPiece() != null &&
              plateau.getPlateau()[yD + 1][xD - 1].getPiece()?.getCouleur() !=
                  this.getCouleur()) {
            if ((xD - 1) == xA && (yD + 1) == yA) {
              deplacement = true;
            }
          }
        }
        if (xD < 7) {
          if (plateau.getPlateau()[yD + 1][xD + 1].getPiece() != null &&
              plateau.getPlateau()[yD + 1][xD + 1].getPiece()?.getCouleur() !=
                  this.getCouleur()) {
            if ((xD + 1) == xA && (yD + 1) == yA) {
              deplacement = true;
            }
          }
        }
      }
    } else {
      if (yD > 0) {
        if (xD > 0) {
          if (plateau.getPlateau()[yD - 1][xD - 1].getPiece() != null &&
              plateau.getPlateau()[yD - 1][xD - 1].getPiece()?.getCouleur() !=
                  this.getCouleur()) {
            if ((xD - 1) == xA && (yD - 1) == yA) {
              deplacement = true;
            }
          }
        }
        if (xD < 7) {
          if (plateau.getPlateau()[yD - 1][xD + 1].getPiece() != null &&
              plateau.getPlateau()[yD - 1][xD + 1].getPiece()?.getCouleur() !=
                  this.getCouleur()) {
            if ((xD + 1) == xA && (yD - 1) == yA) {
              deplacement = true;
            }
          }
        }
      }
    }
    return deplacement;
  }

  bool checkPriseEnPassant(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    if (this.getCouleur() == "noir") {
      if (yD == 4) {
        if (xD > 0) {
          if (plateau.getPlateau()[yD + 1][xD - 1].getPiece() == null &&
              plateau.getPlateau()[yD][xD - 1].getPiece() is Pion) {
            if (plateau.getPlateau()[yD][xD - 1].getPiece()?.getCouleur() !=
                    this.getCouleur() &&
                ListEquality().equals(
                    plateau.getHistoriqueCoup()[
                        plateau.getHistoriqueCoup().length - 1],
                    [xD - 1, yD + 2, xD - 1, yD])) {
              if ((xD - 1) == xA && (yD + 1) == yA) {
                deplacement = true;
              }
            }
          }
        }
        if (xD < 7) {
          if (plateau.getPlateau()[yD + 1][xD + 1].getPiece() == null &&
              plateau.getPlateau()[yD][xD + 1].getPiece() is Pion) {
            if (plateau.getPlateau()[yD][xD + 1].getPiece()?.getCouleur() !=
                    this.getCouleur() &&
                ListEquality().equals(
                    plateau.getHistoriqueCoup()[
                        plateau.getHistoriqueCoup().length - 1],
                    [xD + 1, yD + 2, xD + 1, yD])) {
              if ((xD + 1) == xA && (yD + 1) == yA) {
                deplacement = true;
              }
            }
          }
        }
      }
    } else {
      if (yD == 3) {
        if (xD > 0) {
          if (plateau.getPlateau()[yD - 1][xD - 1].getPiece() == null &&
              plateau.getPlateau()[yD][xD - 1].getPiece() is Pion) {
            if (plateau.getPlateau()[yD][xD - 1].getPiece()?.getCouleur() !=
                    this.getCouleur() &&
                ListEquality().equals(
                    plateau.getHistoriqueCoup()[
                        plateau.getHistoriqueCoup().length - 1],
                    [xD - 1, yD - 2, xD - 1, yD])) {
              if ((xD - 1) == xA && (yD - 1) == yA) {
                deplacement = true;
              }
            }
          }
        }
        if (xD < 7) {
          if (plateau.getPlateau()[yD - 1][xD + 1].getPiece() == null &&
              plateau.getPlateau()[yD][xD + 1].getPiece() is Pion) {
            if (plateau.getPlateau()[yD][xD + 1].getPiece()?.getCouleur() !=
                    this.getCouleur() &&
                ListEquality().equals(
                    plateau.getHistoriqueCoup()[
                        plateau.getHistoriqueCoup().length - 1],
                    [xD + 1, yD - 2, xD + 1, yD])) {
              if ((xD + 1) == xA && (yD - 1) == yA) {
                deplacement = true;
              }
            }
          }
        }
      }
    }
    return deplacement;
  }
}
