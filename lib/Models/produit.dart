class Produit {
  String nomDuProduit;
  int prix;
  String description;
  String image1;
  String image2;
  String image3;
  int quantite;
  String selectImage;
  int numberImages;
  String id;
  int numberStar;

  Produit(
      {this.nomDuProduit,
      this.prix,
      this.description,
      this.image1,
      this.image2,
      this.image3,
      this.quantite,
      this.selectImage,
      this.id,
      this.numberStar,
      this.numberImages});

  Produit.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        description = donnees["description"],
        image1 = donnees["image1"],
        image2 = donnees["image2"],
        image3 = donnees["image3"],
        quantite = donnees["quantite"],
        selectImage = donnees["selectImage"],
        numberImages = donnees["numberImages"],
        numberStar= donnees["numberStar"],
         id= donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "image2": image2,
      "image3": image3,
      "quantite": quantite,
      "selectImage": selectImage,
      "numberImages": numberImages,
      "numberStar": numberStar,
       "id":id
    };
  }
}
