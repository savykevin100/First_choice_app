

class PanierClasse {
  String nomDuProduit;
  int prix;
  String description;
  String image1;
  String id;
  bool etatSurMesure;
  String taille;
  String idProduitCategorie;
  int numberStar;
  String categorie;
  String sousCategorie;


  PanierClasse(
      {this.nomDuProduit,
        this.prix,
        this.description,
        this.image1,
        this.id,
        this.etatSurMesure,
        this.taille,
        this.idProduitCategorie,
        this.numberStar,
        this.categorie,
        this.sousCategorie
    });

  PanierClasse.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        description = donnees["description"],
        image1 = donnees["image1"],
        etatSurMesure = donnees["etatSurMesure"],
        taille = donnees["taille"],
        idProduitCategorie = donnees["idProduitCategorie"],
        numberStar = donnees["numberStar"],
        categorie = donnees["categorie"],
        sousCategorie = donnees["sousCategorie"],
      id= donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "etatSurMesure":etatSurMesure,
      "taille":taille,
      "idProduitCategorie":idProduitCategorie,
      "numberStar":numberStar,
      "categorie":categorie,
      "sousCategorie":sousCategorie,
      "id":id,

    };
 }
}