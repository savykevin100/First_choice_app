
class Utilisateur {
  String nomComplet;
  String sexe;
  String age;
  String numeroDePayement;
  String email;



  Utilisateur(
      {this.nomComplet,
      this.sexe,
      this.age,
      this.numeroDePayement,
      this.email,
    });

  Utilisateur.fromMap(Map<String, dynamic> donnees, String id)
      : nomComplet = donnees["nomComplet"],
        sexe = donnees["sexe"],
        age = donnees["age"],
        numeroDePayement = donnees["numeroDePayement"],
        email = donnees["email"];


  Map<String, dynamic> toMap() {
    return {
    "nomComplet": nomComplet,
    "sexe":sexe,
    "age":age,
    "numeroDePayement":numeroDePayement,
    "email":email,

    };
   }
  }
