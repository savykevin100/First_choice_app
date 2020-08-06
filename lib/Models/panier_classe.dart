

class PanierClasse {
  String nomDuProduit;
  int prix;
  String description;
  String image1;
  String id;
  bool etatSurMesure;
  String taille;


  PanierClasse(
      {this.nomDuProduit,
        this.prix,
        this.description,
        this.image1,
        this.id,
        this.etatSurMesure,
        this.taille
    });

  PanierClasse.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        description = donnees["description"],
        image1 = donnees["image1"],
        etatSurMesure = donnees["etatSurMesure"],
        taille = donnees["taille"],
      id= donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "etatSurMesure":etatSurMesure,
      "taille":taille

    };
 }
}