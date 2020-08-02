

class PanierClasse {
  String nomDuProduit;
  int prix;
  String description;
  String image1;
  String id;


  PanierClasse(
      {this.nomDuProduit,
        this.prix,
        this.description,
        this.image1,
        this.id,
    });

  PanierClasse.fromMap(Map<String, dynamic> donnees, String id)
      : nomDuProduit = donnees["nomDuProduit"],
        prix = donnees["prix"],
        description = donnees["description"],
        image1 = donnees["image1"],
        id= donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "nomDuProduit": nomDuProduit,
      "prix": prix,
      "description": description,
      "image1": image1,
      "id":id
    };
 }
}