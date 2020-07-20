import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService
      ._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

 Future<void> addUtilisateur(Utilisateur utilisateur, String idDocument) {
    return _db.collection("Utilisateurs").document(idDocument).setData(utilisateur.toMap());
  }

  Future<void> addProduitFavorisUser(ProduitsFavorisUser produit, String document){
    return _db.collection("Utilisateurs").document(document).collection("ProduitsFavoirsUser").add(produit.toMap());
  }

  Future<void> addPanier(PanierClasse produit, String document, String id){
    return _db.collection("Utilisateurs").document(document).collection("Panier").document(id).setData(produit.toMap());
  }

  /* Récupération des catégories de la base de données*/
  Stream<List<Utilisateur>> getUtilisateurs() {
    return _db.collection("Utilisateurs").snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => Utilisateur.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }
/* Fin de la récupération des catégories de la base de données*/


/*



/*Récupération categories*/
Stream<List<InfoCategories>> getCategories() {
    return _db.collection("Catégories").snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => InfoCategories.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }
  /*Fin de la récupération*/

/*Récupération des sous_categories*/
Stream<List<InfoCategories>> getSousCategories() {
    return _db.collection("sous-categories").snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => InfoCategories.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }
  
  /*Fin de la récupération*/

/*Recuperation du produit*/
Stream<List<Produit>> getProduit() {
    return _db.collection("produit").snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => Produit.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }

  Stream<List<ProduitsFavorisUser>> getProduitsFavorisUser(String id) {
    return _db.collection("Utilisateurs").document(id).collection("ProduitsFavoirsUser").snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => ProduitsFavorisUser.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }

  Stream<List<PanierClasse>> getProduitPanier(String id) {
    return _db.collection("Utilisateurs").document(id).collection("Panier").snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => PanierClasse.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }



/* Fonction qui permet d'ajouter les variables spécifiques aux utilisateurs*/
Future<void> addProduitFavorisUser(ProduitsFavorisUser produit, String document){
    return _db.collection("Utilisateurs").document(document).collection("ProduitsFavoirsUser").add(produit.toMap());
  }

  Future<void> addFavoris(Produit produit, String document){
    return _db.collection("Utilisateurs").document(document).collection("Favoris").add(produit.toMap());
  }

  Future<void> deleteFavoris(String document, String document1){
    return _db.collection("Utilisateurs").document(document)
        .collection("Favoris").document(document1).delete();
  }

  Stream<List<Produit>> getFavoris(String document) {
    return _db.collection("Utilisateurs").document(document).collection(
        "Favoris").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Produit.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }

  Future<void> addPanier(PanierClasse produit, String document, String id){
    return _db.collection("Utilisateurs").document(document).collection("Panier").document(id).setData(produit.toMap());
  }


  Future<void> addPanierSansId(PanierClasse produit, String document){
    return _db.collection("Utilisateurs").document(document).collection("Panier").add(produit.toMap());
  }
  /*
  Stream<List<Produit>> getProduits(String titreCategorie) {
    return _db.collection(titreCategorie).snapshots().map(
          (snapshot) =>
          snapshot.documents.map(
                (doc) => Produit.fromMap(doc.data, doc.documentID),
          ).toList(),
    );
  }







Future<void> updateUtilisateur(String document, Utilisateur utilisateur){
    return _db.collection("Utilisateurs").document(document).updateData(utilisateur.toMap());
}



 

  /// Fonction pour ajouter les messages
   Future<void> addMessage(Messages messages){
    return _db.collection("Messages").document().setData((messages.toMap()));
   }

 /// Fonction pour obtenir les messages

 /* Stream<List<Messages>> getMessages(String document) {
    return _db.collection("Utilisateurs").document(document).collection(
        "Messages").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Messages.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }*/


 /// Fonction pour l'ajout des favoris pour la vérification de l'etat ajout ou non des produits

  
 Stream<List<Favories>> getEtat(String document ) {
    return _db.collection("Utilisateurs").document(document).collection("EtatProduit").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Favories.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }





  Future<void> updateEtatFavoris(String document, Favories favories){
    return _db.collection("Utilisateurs").document(document).updateData(favories.toMap());
  }








  Stream<List<Messages>> getMessages() {
    return _db.collection("Messages").snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Messages.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }
*/*/
}
