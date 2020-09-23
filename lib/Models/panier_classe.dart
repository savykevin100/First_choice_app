

class PanierClasse {
  String nomDuProduit;
  int prix;
  String description;
  String image1;
  String id;
  String taille;
  String idProduitCategorie;
  int numberStar;
  String categorie;
  String sousCategorie;
  String reference;


  PanierClasse(
      {this.nomDuProduit,
        this.prix,
        this.description,
        this.image1,
        this.id,
        this.taille,
        this.idProduitCategorie,
        this.numberStar,
        this.categorie,
        this.reference,
        this.sousCategorie
    });

  PanierClasse.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        description = donnees["description"],
        image1 = donnees["image1"],
        taille = donnees["taille"],
        idProduitCategorie = donnees["idProduitCategorie"],
        numberStar = donnees["numberStar"],
        categorie = donnees["categorie"],
        reference = donnees["reference"],
        sousCategorie = donnees["sousCategorie"],
      id= donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "taille":taille,
      "idProduitCategorie":idProduitCategorie,
      "numberStar":numberStar,
      "categorie":categorie,
      "reference":reference,
      "sousCategorie":sousCategorie,
      "id":id,

    };
 }
}