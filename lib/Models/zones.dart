class Zones {
 String q1;
 String q2;
 String q3;
 int prix;
  Zones({this.q1, this.q2, this.q3, this.prix, });

  Zones.fromMap(Map<String, dynamic> donnees, String quantite)
      : q1 = donnees["q1"],
        q2 = donnees["q2"],
        q3 = donnees["q3"],
        prix = donnees["prix"];


  Map<String, dynamic> toMap() {
    return {
      "q1": q1,
      "q2": q2,
      "q3": q3,
      "prix":prix
    };
  }
}