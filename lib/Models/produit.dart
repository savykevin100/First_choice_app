class Produit {
  String nomDuProduit;
  int prix;
  String description;
  String image1;
  String image2;
  String image3;
  String selectImage;
  int numberImages;
  String id;
  int numberStar;
  String taille;
  String categorie;
  String sousCategorie;
  String idProduitCategorie;
  String expiryBadgeNew;
  String reference;

  Produit(
      {this.nomDuProduit,
        this.prix,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.selectImage,
        this.id,
        this.numberStar,
        this.taille,
        this.sousCategorie,
        this.categorie,
        this.expiryBadgeNew,
        this.reference,
        this.idProduitCategorie,
        this.numberImages});

  Produit.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        image1 = donnees["image1"],
        image2 = donnees["image2"],
        image3 = donnees["image3"],
        selectImage = donnees["selectImage"],
        numberImages = donnees["numberImages"],
        numberStar = donnees["numberStar"],
        taille = donnees["taille"],
        categorie = donnees["categorie"],
        expiryBadgeNew = donnees["expiryBadgeNew"],
        sousCategorie = donnees["sousCategorie"],
        id = donnees["id"],
        reference = donnees["reference"],
        description = donnees["description"],
        idProduitCategorie = donnees["idProduitCategorie"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "image2": image2,
      "image3": image3,
      "expiryBadgeNew": expiryBadgeNew,
      "selectImage": selectImage,
      "numberImages": numberImages,
      "numberStar": numberStar,
      "taille": taille,
      "categorie": categorie,
      "sousCategorie": sousCategorie,
      "id": id,
      "reference": reference,
      "idProduitCategorie": idProduitCategorie
    };
  }
}