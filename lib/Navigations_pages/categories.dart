import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  ScrollController controller = ScrollController();
  bool val=false;
  int ajoutPanier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Catégories", context: context, controller: controller, nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      drawer:  ProfileSettings(userCurrent: Renseignements.emailUser),
      body: ListView(
        shrinkWrap: true,
        controller: controller,
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: largeurPerCent(20, context), vertical: longueurPerCent(20, context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: HexColor("#DDDDDD"),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding:  EdgeInsets.only(left: largeurPerCent(20, context)),
                    child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                  ),
                  labelText: "Rechercher un produit",
                  labelStyle: TextStyle(
                      color: HexColor('#9B9B9B'),
                      fontSize: 17.0,
                      fontFamily: 'MonseraLight'),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 5, left:100),

                ),
              )),
          Center(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(right: largeurPerCent(10, context)),
                  child: Text("HOMMES", style: TextStyle(color:HexColor("#001c36"), fontFamily: "MonseraBold", fontSize: 20),),
                ),
                LiteRollingSwitch(
                  //initial value
                  value: val,
                  textOn: '',
                  textOff: '',
                  colorOn: Colors.pink,
                  colorOff: HexColor("#001c36"),
                  iconOn: Icons.account_circle,
                  iconOff: Icons.account_circle,
                  textSize: 16.0,
                  animationDuration: Duration(seconds: 1),
                  onChanged: (bool state) {

                  },
                ),
                Padding(
                  padding:  EdgeInsets.only(left: largeurPerCent(10, context)),
                  child: Text("FEMMES", style: TextStyle(color: Colors.pink, fontFamily: "MonseraBold", fontSize: 20),),
                ),
              ],
            ),
          ),
          SizedBox(height: longueurPerCent(30, context),),
          Padding(
            padding: EdgeInsets.only(
                top: longueurPerCent(20, context),
                left: largeurPerCent(10, context), bottom: longueurPerCent(20, context)),
            child: Text(
              "Catégories",
              style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 22,
                  fontFamily: "MonseraBold"),
            ),
          ),
        ],
      ),
    );
  }

  Widget MenFemale(){
    if(val==true){
       product_grid_view();
    } else{
       Text("Je suis la catégorie");
    }
  }

/* body:  , */
}
