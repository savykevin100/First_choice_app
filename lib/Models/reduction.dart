
class ReductionModel {
  String genre;
  String nomCategorie;
  bool status;
  int pourcentageReduction;
  String expiryDate;
  String id;


  ReductionModel({this.genre, this.nomCategorie, this.id, this.status, this.expiryDate, this.pourcentageReduction});


  ReductionModel.fromMap(Map<String, dynamic> donnees, String id)
      : genre = donnees["genre"],
        nomCategorie = donnees["nomCategorie"],
        status = donnees["status"],
        expiryDate = donnees["expiryDate"],
        pourcentageReduction = donnees["pourcentageReduction"],
        id = donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "genre": genre,
      "nomCategorie":nomCategorie,
      "status":status,
      "pourcentageReduction":pourcentageReduction,
      "expiryDate":expiryDate,
      "id":id,
    };
  }
}