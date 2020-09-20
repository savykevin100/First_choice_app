class InformationsGenerales {

  String image1;
  String image2;
  String image3;
  int nombreCommande;


  InformationsGenerales(
      {
        this.image1,
        this.image2,
        this.image3,
        this.nombreCommande
      });

  InformationsGenerales.fromMap(Map<String, dynamic> donnees, String id)
      :
        image1 = donnees["image1"],
        image2 = donnees["image2"],
        image3 = donnees["image3"],
        nombreCommande = donnees["nombreCommande"];


  Map<String, dynamic> toMap() {
    return {
      "image1": image1,
      "image2": image2,
      "image3": image3,
      "nombreCommande": nombreCommande,


    };
  }
}