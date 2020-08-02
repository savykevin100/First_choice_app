class InfoCategories {
  String imagePath;
  String nomCategorie;

  InfoCategories({this.imagePath, this.nomCategorie});


   InfoCategories.fromMap(Map<String, dynamic> donnees, String id)
      : imagePath = donnees["imagePath"],
        nomCategorie = donnees["nomCategorie"];

  Map<String, dynamic> toMap() {
    return {
    "imagePath": imagePath,
    "nomCategorie":nomCategorie,
    };
   }
}