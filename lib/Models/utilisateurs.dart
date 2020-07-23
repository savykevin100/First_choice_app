
class Utilisateur {
  String nomComplet;
  String sexe;
  String age;
  String numeroDePayement;
  String email;
  int nbAjoutPanier;



  Utilisateur(
      {this.nomComplet,
      this.sexe,
      this.age,
      this.numeroDePayement,
      this.email,
      this.nbAjoutPanier
    });

  Utilisateur.fromMap(Map<String, dynamic> donnees, String id)
      : nomComplet = donnees["nomComplet"],
        sexe = donnees["sexe"],
        age = donnees["age"],
        numeroDePayement = donnees["numeroDePayement"],
        email = donnees["email"],
        nbAjoutPanier = donnees["nbAjoutPanier"];



  Map<String, dynamic> toMap() {
    return {
    "nomComplet": nomComplet,
    "sexe":sexe,
    "age":age,
    "numeroDePayement":numeroDePayement,
    "email":email,
      "nbAjoutPanier":nbAjoutPanier,

    };
   }
  }
