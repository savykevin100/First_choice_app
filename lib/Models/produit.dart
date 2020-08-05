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
  bool surMesure;
  String taille;

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
      this.surMesure,
      this.taille,
      this.numberImages});

  Produit.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        description = donnees["description                                                                                                                                                                                                                                                                                                                                                                                "],
        image1 = donnees["image1"],
        image2 = donnees["image2"],
        image3 = donnees["image3"],
        selectImage = donnees["selectImage"],
        numberImages = donnees["numberImages"],
        numberStar = donnees["numberStar"],
        taille = donnees["taille"],
        surMesure = donnees["surMesure"],
        id = donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "image2": image2,
      "image3": image3,
      "selectImage": selectImage,
      "numberImages": numberImages,
      "numberStar": numberStar,
      "surMesure": surMesure,
      "taille": taille,
      "id": id
    };
  }
}
