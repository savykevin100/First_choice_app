class ProduitsFavorisUser {
  String imageSelect;
  int quantite;
  String imagePrincipaleProduit;
  bool etatIconeFavoris;
  int ajoutPanier;

  ProduitsFavorisUser(
      {this.imageSelect,
      this.quantite,
      this.imagePrincipaleProduit,
      this.etatIconeFavoris,
      this.ajoutPanier});

  ProduitsFavorisUser.fromMap(Map<String, dynamic> donnees, String quantite)
      : imageSelect = donnees["imageSelect"],
        quantite = donnees["quantite"],
        imagePrincipaleProduit = donnees["imagePrincipaleProduit"],
        etatIconeFavoris = donnees["etatIconeFavoris"],
        ajoutPanier = donnees["ajoutPanier"];

  Map<String, dynamic> toMap() {
    return {
      "imageSelect": imageSelect,
      "quantite": quantite,
      "imagePrincipaleProduit": imagePrincipaleProduit,
      "etatIconeFavoris": etatIconeFavoris,
      "ajoutPanier": ajoutPanier
    };
  }
}

/*Cette classe ProduitsFavorisUser est utilisée pour récuperer les infos spécifiques des produits pour l'utilisateur
connecté dont les favoris, la quantité du produit, l'image selectionnée et autres
 */
