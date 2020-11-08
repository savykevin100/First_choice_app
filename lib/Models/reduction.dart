class ReductionModel {
  String genre;
  String nomCategorie;
  int pourcentageReduction;
  String expiryDate;
  String id;
  int numberStar;


  ReductionModel({this.genre, this.nomCategorie, this.id, this.expiryDate, this.pourcentageReduction, this.numberStar});


  ReductionModel.fromMap(Map<String, dynamic> donnees, String id)
      : genre = donnees["genre"],
        nomCategorie = donnees["nomCategorie"],
        expiryDate = donnees["expiryDate"],
        pourcentageReduction = donnees["pourcentageReduction"],
        numberStar = donnees["numberStar"],
        id = donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "genre": genre,
      "nomCategorie":nomCategorie,
      "pourcentageReduction":pourcentageReduction,
      "expiryDate":expiryDate,
      "numberStar":numberStar,
      "id":id,
    };
  }
}