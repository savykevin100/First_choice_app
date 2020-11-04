import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';


class ConditionGenerales extends StatefulWidget {
  static String id="ConditionGenerales";
  @override
  _ConditionGeneralesState createState() => _ConditionGeneralesState();
}

class _ConditionGeneralesState extends State<ConditionGenerales> {
  ScrollController controller=ScrollController();
  int ajoutPanier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conditions Générales",
          style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
        ),
      ),
      backgroundColor: HexColor("#F5F5F5"),

      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: longueurPerCent(30.0, context),),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Text("CONDITIONS GENERALES D'UTILISATION",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 17,
                        fontFamily: "MonseraBold",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("1. A PROPOS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("1er CHOIX est une application mobile de vente en ligne. Elle est conçue et développée par FOLLOW ME, entreprise de droit béninois opérant dans le Marketing & la Communication digitale, désignée au terme des présentes sous le vocable le ‘’Promoteur’’",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Les présentes dispositions ci-après désignées sous les vocables ‘’Conditions Générales d’Utilisation’’ ou ‘’CGU’’ sont réputées établies afin régir les usages et rapports entre les internautes ci-après désignés sous le vocable ‘’Utilisateur’’ accédant ponctuellement ou de façon récurrente à 1er CHOIX, ci-après désigné sous le vocable ‘’Plateforme’’ et ladite Plateforme.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),

                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("2. CHAMP D'APPLICATION",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Les présentes conditions générales d’utilisation s’appliquent à toute visite ou utilisation de la Plateforme et de ses informations par un internaute. En visitant ou utilisant la Plateforme, l’Utilisateur reconnaît avoir pris connaissance des présentes CGU et accepte expressément les droits et obligations qui y sont mentionnés.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Il peut toutefois et ce à titre exceptionnel, être dérogé aux dispositions des CGU par un accord écrit. Ces dérogations peuvent consister en la modification, l’ajout ou la suppression des clauses auxquelles elles se rapportent et n’ont aucune incidence sur l’application des autres dispositions des CGU.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("3. INSCRIPTION D'UTILISATEUR",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("L’accès aux services offert par la Plateforme est conditionné par l’inscription de l’Utilisateur.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("L’inscription et l’accès aux services de la Plateforme sont réservés exclusivement aux personnes physiques, juridiquement capables, ayant rempli et validé le formulaire d’inscription disponible en ligne sur la Plateforme, ainsi que les présentes CGU.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Lors de l’inscription, l’Utilisateur s’engage à fournir des informations exactes sincères et actuelles le concernant et ayant rapport à son état civil. L’Utilisateur devra en outre procéder à une vérification régulière des données le concernant afin d’en conserver l’exactitude.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("L’Utilisateur doit ainsi fournir impérativement une adresse e-mail valide sur laquelle la Plateforme lui adressera une confirmation de son inscription à ses services. Une adresse de messagerie électronique ne peut être utilisée plusieurs fois pour s’inscrire aux services.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Toute communication réalisée par la Plateforme et ses partenaires est en conséquence réputée avoir été réceptionnée et lue par l’Utilisateur. Ce dernier s’engage donc à consulter régulièrement les messages reçus sur cette adresse e-mail et, le cas échéant, à répondre dans un délai raisonnable.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Une seule inscription est admise par personne physique.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("L’utilisateur en saisissant son e-mail peu donc accéder à un espace dont l’accès lui est exclusivement réservé en complément de la saisie de son mot de passe.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("L’e-mail et le mot de passe sont modifiables en ligne par l‘Utilisateur dans son espace personnel. Le mot de passe est personnel et confidentiel, l’Utilisateur s’engage ainsi à ne pas le communiquer à des tiers.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("4. ACCES ET NAVIGATION",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Nous prenons toutes mesures techniques et raisonnables nécessaires pour assurer l’accessibilité et le fonctionnement ininterrompu et sécurisé de notre plateforme. Toutefois, nous ne pouvons pas offrir de garantie d’opérabilité absolue et il faut dès lors considérer nos actions comme étant couvertes par une obligation de moyen.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("En dépit de toutes dispositions techniques prises, il peut arriver que des risques existent à l’utilisation de la Plateforme. Nous déclinons toutes responsabilités quant aux dommages pouvant résulter de possibles dysfonctionnements, interruptions, défauts ou encore d’éléments nuisibles, présents sur la Plateforme.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Nous nous réservons le droit de restreindre l’accès à la Plateforme ou d’interrompre son fonctionnement à tout moment, sans obligation de notification préalable.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("5. CONTENU",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("L’équipe du support technique pilotée par le Promoteur, détermine en grande partie le contenu de la Plateforme et prend grand soin des informations présentes sur celle-ci. Nous prenons toutes les mesures possibles pour maintenir notre Plateforme aussi complète, précise et à jour que possible. Nous nous réservons le droit de modifier, compléter ou supprimer à tout moment la Plateforme et son contenu sans que la responsabilité de l’Équipe ne puisse être engagée à ce titre.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Le Promoteur ne peut offrir de garantie absolue concernant la qualité de l’information présente sur la Plateforme. Il est donc possible que cette information ne soit pas toujours complète, exacte, suffisamment précise ou à jour. Par conséquent, le Promoteur et son équipe ne pourront être tenus responsables des dommages directs ou indirects, que l’Utilisateur subirait par l’information présente sur la Plateforme.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("6. PROPRIETE INTELLECTUELLE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Tout le contenu de la Plateforme, incluant, de façon non limitative, les graphismes, images, textes, vidéos, animations, sons, logos, gifs et icônes ainsi que leur mise en forme sont la propriété exclusive de FOLLOW ME à l'exception des marques, logos ou contenus appartenant à d'autres sociétés partenaires ou auteurs.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("7. PROTECTION DES DONNEES PERSONNELLES",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Les données personnelles fournies par l’Utilisateur lors de sa visite ou de l’utilisation de la Plateforme, sont collectées et traitées par 1er CHOIX exclusivement à des fins internes. 1er CHOIX assure à ses utilisateurs qu’elle attache la plus grande importance à la protection de leur vie privée et de leurs données personnelles et qu’elle s’engage toujours à communiquer de manière claire et transparente sur ce point.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("1er CHOIX s’engage à respecter la législation applicable en matière de protection de données personnelles et de la vie privée à l’égard des traitements de données à caractère personnel tel que disposé dans le code béninois du numérique.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("8. CONFIDENTIALITE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Les données personnelles de l’Utilisateur sont traitées conformément à la Politique de Confidentialité de la Plateforme sur laquelle elle est disponible.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("9. RESPONSABILITE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Le choix et l'achat d'une marchandise sont faits sous la seule et unique responsabilité du Client. Par conséquent, l'impossibilité totale ou partielle d'utiliser les produits notamment pour des causes d'incompatibilité ou de mauvaises mesures ou de manque de savoir-faire à l’installation des produits ne saurait donner lieu à aucun dédommagement, remboursement ou mise en cause de la responsabilité du 1er CHOIX. ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Le Client est responsable de l’exhaustivité, la véracité des renseignements qu’il fournit à 1er CHOIX notamment lors du choix du produit ou de l’adresse de livraison.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("1er CHOIX ne peut être tenue pour responsable d’éventuelles erreurs de saisie à l’origine d’erreurs de livraison ou autres problèmes. 1er CHOIX ne peut également être tenue responsable d’éventuelles erreurs commises par le Client et/ou du non-respect par le Client des modalités de livraison et rendez-vous qu’il aura lui-même fixé avec le transporteur. Le cas échéant, les frais nécessaires pour la réexpédition et le stockage des produits seront à la charge du Client.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("10. VIOLATIONS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Attendu que les présentes CGU sont régies par la loi N° 2017-20 portant Code du Numérique applicable en République du Bénin, toute violation constatée dans les usages de la Plateforme seront passibles des peines encourues aux termes du même Code du Numérique.",
                    textAlign: TextAlign.left,style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("11. MODIFICATIONS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Nous nous réservons le droit de modifier nos CGU à tout moment sans notification préalable, mais nous engageons à vous tenir informé de toute modification et à ne vous soumettre qu’à l’application des dispositions en vigueur au moment de vos accès et usage de la Plateforme.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(30.0, context),),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Text("CONDITIONS GENERALES DE VENTE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 17,
                        fontFamily: "MonseraBold",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("1. A PROPOS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Les présentes Conditions Générales de Ventes (ci-après désignées les 'CGV') sont conclues entre, d'une part, l’entreprise FOLLOW ME, immatriculée au Registre du Commerce et de Crédits Mobilier sous le numéro RB/COT/19 A 51052 et dont le siège est situé à l’Ilot 1140, VODJE (Bénin), et d'autre part, tout utilisateur de l’application 1er CHOIX souhaitant effectuer un achat, via l’application ou utiliser ses services (ci-après désigné le(s) Client(s)).",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("L'ensemble des informations sont présentées en langue française. Le client déclare avoir la pleine capacité juridique lui permettant de s'engager au titre des présentes conditions.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),

                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("2. PRODUITS A LA VENTE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("La plateforme 1er CHOIX met en vente, des biens d’occasion. Les biens et produits sont mis en vente par unité. Chaque unité de bien ou produit mis en vente fait l’objet d’une fiche disponible en vitrine sur le support digital de la plateforme. Chaque fiche renseigne sur la nature, l’enseigne (ou marque), le stock et la qualité du produit auquel elle se rapporte. La nature et l’enseigne sont nominales. Le stock est numérique. La qualité quant à elle est exprimée en termes d’échelle  illustrée par des étoiles, en rapport avec un barème de trois étoiles. A ce titre, 1er CHOIX ne saurait être tenu pour responsable des griefs émis quant aux différences liées à la colorimétrie des biens et produits présentés en ligne et ceux livrés à l’acheteur. Par conséquent, toute action en réparation, dédommagement ou remboursement pour le fait sus-cité serait réputée irrecevable, et au demeurant nulle et de nul effet, attendu qu’en validant sa commande, l’Acheteur reconnaît expressément avoir lu, approuvé et souscrit aux présentes dispositions.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("3. DISPONIBILITE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Le principe des ventes de 1er CHOIX réside dans son catalogue. Les articles sont proposés à la vente dans la mesure du stock disponible.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("4. PRIX",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Tous les prix affichés sur la Plateforme sont exprimés en Francs CFA et TTC. ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Le prix à payer est le prix final du (ou des) produits, soit le prix initial augmenté le cas échéant du coût des options de personnalisation choisies par le Client, ainsi que tous les frais accessoires à la commande (comme par exemple, mais non limitativement, les frais de livraison, etc.).",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("1er CHOIX se réserve le droit de modifier ses prix à tout moment. Toutefois, la facturation des produits se fera conformément aux tarifs en vigueur au moment de l’enregistrement des commandes, sous réserve de leur disponibilité.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("5. COMMANDE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("La prise de commande sur la Plateforme, est soumise au respect de la procédure mise en place sur le STORE de 1er CHOIX. Elle est concrétisée par une succession de différentes étapes que le client doit impérativement suivre pour valider sa commande. Le client aura la possibilité, avant de valider définitivement sa commande, de vérifier le détail de celle-ci et son prix total, et de corriger d’éventuelles erreurs, avant de confirmer celle-ci pour exprimer son acceptation. Toute commande confirmée par le Client vaut contrat de vente et acceptation de l’ensemble des stipulations des présentes. ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Une fiche récapitulant la commande (produits, prix, quantité…) sera mise à disposition du client dans l’application, plus précisément dans la rubrique MES COMMANDES par 1er CHOIX. ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Les commandes transmises à 1er CHOIX sont irrévocables et ne pourront être annulées ni modifiées lorsqu’elles sont transmises en logistique/ en traitement.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("6. PAIEMENT",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Les commandes sont payables immédiatement par tout moyen proposé sur la Plateforme. Il n’y aura donc pas d’escompte pratiqué. Le Client trouvera les modes de paiement disponibles après la mise au panier. 1er CHOIX n’accepte aucun mode de paiement autre que ceux mentionnés, dans la mesure où le système n'est pas conçu pour traiter d'autres modes de paiement. ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Le prix à payer est celui indiqué dans l’application au moment de la validation du panier et correspond au cumul du prix des objets choisis, du montant des frais de transport, de celui des autres options qui pourraient être disponibles. La vente est valablement conclue à réception du paiement. ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(10.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("SECURITE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 0),
                  child: Text("Le règlement de vos achats s’effectue à travers le service de paiement sécurisé fourni par 1ER CHOIX. Toutes les informations personnelles et relatives aux moyens de paiement sont sécurisées.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("7. LIVRAISON",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("1er CHOIX propose deux (02) modes de livraison :",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:0),
                  child: Text("-	Livraison à la Boutique 1ER CHOIX;",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:0),
                  child: Text("-	Livraison à domicile (tout endroit autre que la Boutique 1ER CHOIX)",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Un délai compris entre 60-120 minutes est sera prévu pour toute livraison.  ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("1ER CHOIX ne peut être rendu responsable d’une impossibilité de délivrance en raison d’une imprécision dans l’adresse de livraison, d’une difficulté de passage du livreur pour atteindre l’adresse de livraison du Client, ou de l’absence du Client. En cas d’absence du Client au rendez-vous convenu, de nouveaux frais de livraison pourront être facturés. De même, si le Client demande à être livré à une autre adresse que celle indiquée sur la commande, de nouveaux frais de livraison pourront être facturés. En cas de non-paiement de ces frais, 1ER CHOIX se réserve le droit de ne pas procéder à la livraison du produit. Les risques de dommages résultant de ces contraintes seront également à la charge du Client.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Nous vous invitons à vérifier la correspondance (ou à faire vérifier par le mandataire qui reçoit) des produits à la livraison et ceux de votre commande. Vous devez obligatoirement déballer le colis en présence du livreur, inscrire les réserves manuscrites en faisant signer le livreur à côté.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:5),
                  child: Text("Attention, si vous confiez la réception à un tiers, celui-ci reçoit le colis en votre nom et pour votre compte. Il est responsable à ce titre, vous devez donc lui demander d’être vigilant.   ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("8. RESERVE DE PROPRIETE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("1ER CHOIX se réserve la propriété des biens vendus jusqu'au paiement complet du prix, en principal et accessoire. En cas de procédure de sauvegarde, de redressement ou de liquidation judiciaire du Client, la propriété des biens livrés et restés impayés pourra être revendiquée par 1ER CHOIX. ",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Les présentes dispositions ne font pas obstacle au transfert des risques au Client dès la livraison des biens vendus.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("9. DROIT DE RETRACTION",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Le droit de rétraction du Client n’est opposable à 1er CHOIX qu’au stade de la précommande. En cas de validation de la commande par réalisation du paiement, le droit de rétraction du Client est révoqué et de fait, non opposable à la plateforme.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("10. PROPRIETE INTELLECTUELLE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Tous les textes, commentaires, ouvrages, illustrations et images reproduits sur le site du 1ER CHOIX sont réservés au titre du droit d’auteur ainsi qu’au titre de la propriété intellectuelle et pour le monde entier. A ce titre et conformément aux dispositions du Code de la Propriété Intellectuelle, seule l’utilisation pour un usage privé est autorisée, sous réserve de dispositions différentes, voir plus restrictives du Code de la Propriété Intellectuelle. Toute autre utilisation est constitutive de contrefaçon et sanctionnée au titre de la Propriété Intellectuelle sauf autorisation préalable du 1ER CHOIX. Toute reproduction totale ou partielle du catalogue du 1ER CHOIX est strictement interdite.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("11. SERVICE APRES VENTE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("1ER CHOIX se réserve le droit de fournir à tout Client de son choix discrétionnaire, un service après-vente portant sur des corrections à opérer sur les commandes livrées par ses soins.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("12. RESPONSABILITE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Le choix et l'achat d'une marchandise sont faits sous la seule et unique responsabilité du Client. Par conséquent, l'impossibilité totale ou partielle d'utiliser les produits notamment pour des causes d'incompatibilité ou de mauvaises mesures ou de manque de savoir-faire à l’installation des produits ne saurait donner lieu à aucun dédommagement, remboursement ou mise en cause de la responsabilité de 1ER CHOIX.",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Le Client est responsable de l’exhaustivité, la véracité des renseignements qu’il fournit à 1ER CHOIX notamment lors du choix du produit, de la saisie des mesures ou de l’adresse de livraison ; par conséquent, 1ER CHOIX ne peut être tenue pour responsable d’éventuelles erreurs de saisie à l’origine d’erreurs de livraison ou autres problèmes. La Plateforme ne peut également être tenue responsable d’éventuelles erreurs commises par le Client et/ou du non-respect par le Client des modalités de livraison et rendez-vous qu’il aura lui-même fixé avec le transporteur. Le cas échéant, les frais nécessaires pour la réexpédition et le stockage des produits seront à la charge du Client. ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Sans écarter les paragraphes précédents, la responsabilité de 1ER CHOIX aux termes des présentes Conditions Générales de Vente ne saurait excéder une somme égale aux sommes payées ou payables lors de la transaction à l'origine de ladite responsabilité, quelle que soit la cause ou la forme de l'action concernée. Sont considérés comme cas fortuit ou force majeure exonératoires de responsabilité tous les faits ou circonstances irrésistibles, imprévisibles et indépendants de la volonté des Parties notamment en cas de grève totale ou partielle de transporteurs et de catastrophes naturelles telles que les inondations ou incendies. ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("13. LITIGES",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Les présentes Conditions Générales de Vente sont régies par les dispositions légales et réglementaires en vigueur en matières commerciale et numérique en République du Bénin.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text("Tout litige pouvant découler des rapports commerciaux établis entre les Clients et la Plateforme, seront soumis dans une procédure de règlement amiable, à la Chambre Arbitrale de la Chambre de Commerce et d’Industrie du Bénin. Faute d’accord, compétence est donnée au Tribunal de Commerce de Cotonou pour connaître de l’affaire opposant les parties.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("14. DISPOSITIONS PARTICULIERES",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom:40,top: 5),
                  child: Text("Nous nous réservons le droit de modifier les présentes CGV à tout moment sans notification préalable. Nous nous engageons toutefois à tenir nos Clients informés de toute modification et à ne les soumettre qu’à l’application des dispositions en vigueur au moment de leurs accès et usage de la Plateforme.",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "Monsera_Light",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}