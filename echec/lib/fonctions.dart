import "dart:io";

class MesFonctions {
  static int saisirInt() {
    bool valide = false;
    int i = 0;
    while (!valide) {
      try {
        i = int.parse(stdin.readLineSync().toString());
        valide = true;
      } catch (e) {
        print("Erreur dans la saisie!");
      }
    }
    return i;
  }

  static double saisirDouble() {
    bool valide = false;
    double i = 0;
    while (!valide) {
      print("Veuillez saisir un double:");
      try {
        i = double.parse(stdin.readLineSync().toString());
        valide = true;
      } catch (e) {
        print("Erreur dans la saisie!");
      }
    }
    return i;
  }

  static String saisirString() {
    bool valide = false;
    String i = "Default";
    while (!valide) {
      print("Veuillez saisir un String:");
      try {
        i = stdin.readLineSync().toString();
        valide = true;
      } catch (e) {
        print("Erreur dans la saisie!");
      }
    }
    return i;
  }

  static bool saisirBool() {
    String? i = "Default";
    while (i != "true" && i != "false") {
      print("Veuillez saisir un bool:");
      i = stdin.readLineSync().toString();
      if (i != "true" && i != "false") {
        print("Erreur dans la saisie!");
      }
    }
    bool b = i.toString().toLowerCase() == "true";
    return b;
  }
}
