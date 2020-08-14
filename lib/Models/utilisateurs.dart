class Utilisateur {
  String nomComplet;
  String sexe;
  String age;
  String numero;
  String email;
  int nbAjoutPanier;
  int orderNumber;

  Utilisateur(
      {this.nomComplet,
      this.sexe,
      this.age,
      this.numero,
      this.email,
      this.nbAjoutPanier,
      this.orderNumber});

  Utilisateur.fromMap(Map<String, dynamic> donnees, String id)
      : nomComplet = donnees["nomComplet"],
        sexe = donnees["sexe"],
        age = donnees["age"],
        numero = donnees["numero"],
        email = donnees["email"],
        nbAjoutPanier = donnees["nbAjoutPanier"],
        orderNumber = donnees["orderNumber"];

  Map<String, dynamic> toMap() {
    return {
      "nomComplet": nomComplet,
      "sexe": sexe,
      "age": age,
      "numero": numero,
      "email": email,
      "nbAjoutPanier": nbAjoutPanier,
      "orderNumber": orderNumber,
    };
  }
}
