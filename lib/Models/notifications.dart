class
InformationNotification
{

  String titre;
  String description;
  String created;
  String id;



  InformationNotification
      (
      {
        this.titre,
        this.description,
        this.created,
        this.id
      });


  InformationNotification
      .fromMap(Map<String, dynamic> donnees, String id)
      : titre = donnees["titre"],
        description = donnees["description"],
        created = donnees["created"],
        id = donnees["id"];

  Map<String, dynamic> toMap() {
    return {
      "titre": titre,
      "description": description,
      "created": created,
      "id": id,
    };
  }
}