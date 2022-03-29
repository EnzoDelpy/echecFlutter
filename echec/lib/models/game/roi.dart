import 'piece_echec.dart';
import 'plateau.dart';

class Roi extends PieceEchec {
  bool _aBouger = false;

  Roi(String couleur) {
    super.setCouleur(couleur);
  }

  void setABouger(bool aBouger) {
    this._aBouger = aBouger;
  }

  @override
  bool deplacement(Plateau plateau, xD, yD, xA, yA) {
    bool deplacement = false;
    int xMin = -1;
    int xMax = 2;
    int yMin = -1;
    int yMax = 2;
    if (xD == 0) {
      xMin = 0;
    } else if (xD == 7) {
      xMax = 1;
    }
    if (yD == 0) {
      yMin = 0;
    } else if (yD == 7) {
      yMax = 1;
    }

    for (int y = yMin; y < yMax; y++) {
      for (int x = xMin; x < xMax; x++) {
        if (x != 0 || y != 0) {
          if (plateau.getPlateau()[yD + y][xD + x].getPiece() == null) {
            if ((yD + y) == yA && (xD + x) == xA) {
              deplacement = true;
            }
          } else if (plateau
                  .getPlateau()[yD + y][xD + x]
                  .getPiece()
                  ?.getCouleur() !=
              this.getCouleur()) {
            if ((yD + y) == yA && (xD + x) == xA) {
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
