import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';


class APrpos extends StatefulWidget {
  static String id="APrpos";
  @override
  _APrposState createState() => _APrposState();
}

class _APrposState extends State<APrpos> {
  ScrollController controller=ScrollController();
  int ajoutPanier;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: AppBar(
        title: Text(
          "A Propos",
          style: TextStyle(color: Colors.white, fontFamily: "MonseraBold",fontSize: 18),
        ),
      ),
      key: _scaffoldKey,
      body: new SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: longueurPerCent(20.0, context),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("AVANT-PROPOS",
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
              child: Text("Le présent support fournit les Mentions Légales, Conditions Générales d’Utilisation et Conditions Générales de Vente liées à l’utilisation de la plateforme 1er CHOIX conçue, développée et exploitée par FOLLOW ME, entreprise individuelle de droit béninois. Tout utilisateur du support déployé notamment sous la forme d’une application mobile, est invité à prendre connaissance desdits supports légaux qui régissent les rapports entre les différents exploitants de 1er CHOIX.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 15,
                  fontFamily: "Monsera_Light",
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(50.0, context),),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("MENTIONS LEGALES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#001C36"),
                    fontSize: 17,
                    fontFamily: "MonseraBold",
                  ),
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(10.0, context),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("AVERTISSEMENT",
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
              child: Text("Merci de lire intégralement et attentivement les présentes conditions d’utilisation et d’exploitation avant d’accéder à l’application mobile 1er CHOIX. En vous connectant, vous reconnaissez en avoir pris connaissance, les accepter sans réserve et vous engagez à vous conformer à leurs dispositions.",
                textAlign: TextAlign.left,
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
              child: Text("REFERENCE LEGALES",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 16,
                  fontFamily: "MonseraBold",
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(10.0, context),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Éditeur",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 16,
                  fontFamily: "MonseraBold",
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Raison sociale:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("FOLLOW ME",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text("N° d’immatriculation:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("RB/COT/19 A 51052 ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: longueurPerCent(5.0, context),),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text("Siège sociale:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("Ilot 1140, VODJE (Bénin),",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: longueurPerCent(5.0, context),),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text("E-mail:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("followmebenin@gmail.com,",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: longueurPerCent(40.0, context),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child: Text("Développeurs:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold",
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: largeurPerCent(10, context),),
                  Text("SAVY Kévin ",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                  Text("et",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                  Text(" HOUEGBELO Amour",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraRegular",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}