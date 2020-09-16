import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:url_launcher/url_launcher.dart';



class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  launchWhatsApp(String phone) async {
    String url ="https://api.whatsapp.com/send?phone="+phone;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMessenger() async {
    String url ="https://web.facebook.com/messages/t/hermann.savy";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int ajoutPanier;
  ScrollController controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Message",
        controller: controller,
        context: context,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      drawer:  ProfileSettings(
        userCurrent:Renseignements.emailUser,
        firstLetter: Renseignements.emailUser[0],
      ),
      body:ConnexionState(body:  Container(
        height: MediaQuery.of(context).size.height/1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Continuez ",
                style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 50,
                  fontFamily: "MonseraBold",
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(30, context),),
            Center(
              child: Text(
                "sur ",
                style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 40,
                  fontFamily: "MonseraRegular",
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(40, context),),
            Container(
              margin: EdgeInsets.only(bottom: longueurPerCent(10, context),left: longueurPerCent(10, context)),
              height: longueurPerCent(50.0, context),
              width: largeurPerCent(220.0, context),
              child: GestureDetector(
                onTap: () {
                  launchWhatsApp("22996184655");
                },
                child: Material(
                  borderRadius: BorderRadius.circular(7.0),
                  color: HexColor("#55D062"),
                  elevation: 7.0,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: longueurPerCent(10, context)),
                          child: Image.asset("assets/images/1021px-WhatsApp.svg.png",
                            width: largeurPerCent(40, context),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:longueurPerCent(10, context)),
                          child: Text(
                            "WhatsApp",
                            style: TextStyle(
                              color: HexColor("#FFFFFF"),
                              fontSize: 23,
                              fontFamily: "MonseraBold",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(40, context),),
            Container(
              margin: EdgeInsets.only(bottom: longueurPerCent(10, context),left: longueurPerCent(10, context)),
              height: longueurPerCent(50.0, context),
              width: largeurPerCent(220.0, context),
              child: GestureDetector(
                onTap: () {
                    launchMessenger();
                },
                child: Material(
                  borderRadius: BorderRadius.circular(7.0),
                  color: HexColor("#0084FF"),
                  elevation: 7.0,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: longueurPerCent(5, context)),
                          child: Image.asset("assets/images/7d6d999657b076cd4d101b5b93535103.png",
                            width: largeurPerCent(60, context),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:longueurPerCent(0, context)),
                          child: Text(
                            "Messenger",
                            style: TextStyle(
                              color: HexColor("#FFFFFF"),
                              fontSize: 23,
                              fontFamily: "MonseraBold",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),)
    );
  }


}


