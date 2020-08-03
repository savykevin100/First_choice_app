class ProduitsFavorisUser {
  String imageSelect;
  String imagePrincipaleProduit;
  bool etatIconeFavoris;
  int ajoutPanier;
  bool etatSurMesure;


  ProduitsFavorisUser({this.imageSelect,
    this.imagePrincipaleProduit,
    this.etatIconeFavoris,
    this.etatSurMesure,
    this.ajoutPanier});

  ProduitsFavorisUser.fromMap(Map<String, dynamic> donnees, String quantite)
      : imageSelect = donnees["imageSelect"],
        imagePrincipaleProduit = donnees["imagePrincipaleProduit"],
        etatIconeFavoris = donnees["etatIconeFavoris"],
        etatSurMesure = donnees["etatSurMesure"],
        ajoutPanier = donnees["ajoutPanier"];

  Map<String, dynamic> toMap() {
    return {
      "imageSelect": imageSelect,
      "imagePrincipaleProduit": imagePrincipaleProduit,
      "etatIconeFavoris": etatIconeFavoris,
      "etatSurMesure": etatSurMesure,
      "ajoutPanier": ajoutPanier
    };
  }
}

/*Cette classe ProduitsFavorisUser est utilisée pour récuperer les infos spécifiques des produits pour l'utilisateur
connecté dont les favoris, la quantité du produit, l'image selectionnée et autres
 */
