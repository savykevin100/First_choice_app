import 'package:cloud_firestore/cloud_firestore.dart';

class Commandes {
  String nomComplet;
  String telephone;
  String quartier;
  String indication;
  String dateHeureDeLivraison;
  int total;
  int prixLivraison;
  String moyenDePayement;
  String numeroDePayement;
  String lieuDeLivraison;
  List<Map<String, dynamic>> produitsCommander;
  bool livrer;
  String created;

  Commandes(
      {this.nomComplet,
      this.telephone,
      this.quartier,
      this.indication,
      this.dateHeureDeLivraison,
      this.total,
      this.prixLivraison,
      this.moyenDePayement,
      this.numeroDePayement,
      this.produitsCommander,
      this.lieuDeLivraison,
      this.livrer,
      this.created});

  Commandes.fromMap(Map<String, dynamic> donnees, String id)
      : nomComplet = donnees["nomComplet"],
        telephone = donnees["telephone"],
        quartier = donnees["quartier"],
        indication = donnees["indication"],
        dateHeureDeLivraison = donnees["dateHeureDeLivraison"],
        total = donnees["total"],
        prixLivraison = donnees["prixLivraison"],
        moyenDePayement = donnees["moyenDePayement"],
        produitsCommander = donnees["produitsCommander"],
        lieuDeLivraison = donnees["lieuDeLivraison"],
        livrer = donnees["livrer"],
        created = donnees["created"],
        numeroDePayement = donnees["numeroDePayement"];

  Map<String, dynamic> toMap() {
    return {
      "nomComplet": nomComplet,
      "telephone": telephone,
      "quartier": quartier,
      "indication": indication,
      "dateHeureDeLivraison": dateHeureDeLivraison,
      "total": total,
      "prixLivraison": prixLivraison,
      "moyenDePayement": moyenDePayement,
      "numeroDePayement": numeroDePayement,
      "produitsCommander": produitsCommander,
      "lieuDeLivraison": lieuDeLivraison,
      "livrer": livrer,
      "created": created,
    };
  }
}
