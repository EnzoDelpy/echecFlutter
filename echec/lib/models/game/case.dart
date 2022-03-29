import 'piece_echec.dart';

class Case {
  int _coordX;
  int _coordY;
  PieceEchec? _piece;

  Case(this._coordX, this._coordY, this._piece);

  Case.vide(this._coordX, this._coordY);

  int getCoordX() {
    return this._coordX;
  }

  int getCoordY() {
    return this._coordY;
  }

  PieceEchec? getPiece() {
    return this._piece;
  }

  void setCoordX(coord) {
    this._coordX = coord;
  }

  void setCoordY(coord) {
    this._coordY = coord;
  }

  void setPiece(piece) {
    this._piece = piece;
  }
}
