import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

// ignore: must_be_immutable
class Mensuration extends StatefulWidget {
  static String id="Mensuration";
  String genre;
  String titreCategorie;



  @override
  _MensurationState createState() => _MensurationState();
}

class _MensurationState extends State<Mensuration> {

  ScrollController controller = ScrollController();
  String nameUser;
  bool val = false;
  int nombre;

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  void initState() {
    super.initState();
    nombre=1;
    fetchDataUser(Renseignements.emailUser);
  }

  Future<void> fetchDataUser(String id) async {
    await Firestore.instance
        .collection("Utilisateurs")
        .document(id)
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          nameUser = value.data["nomComplet"];
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tableaux des Mensurations",
          style: TextStyle(color: Colors.white, fontFamily: "MonseraBold",fontSize: 16),
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: HexColor("#F5F5F5"),
      body:SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(children: <Widget>[
              SizedBox(height: longueurPerCent(20, context),),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: largeurPerCent(10, context)),
                      child: Text(
                        "HOMME",
                        style: TextStyle(
                            color: HexColor("#FFC30D"),
                            fontFamily: "MonseraBold",
                            fontSize: 18),
                      ),
                    ),
                    LiteRollingSwitch(
                      //initial value
                      value: val,
                      textOn: '',
                      textOff: '',
                      colorOn: Colors.pink,
                      colorOff: HexColor("#FFC30D"),
                      iconOn: Icons.account_circle,
                      iconOff: Icons.account_circle,
                      textSize: 16.0,
                      animationDuration: Duration(milliseconds: 3),
                      onChanged: (bool state) {
                        val=state;
                      },
                      onTap: (){
                        if(nombre==0)setState(() {
                          nombre++;
                        });
                        else setState(() {
                          nombre--;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: largeurPerCent(10, context)),
                      child: Text(
                        "FEMME",
                        style: TextStyle(
                            color: Colors.pink,
                            fontFamily: "MonseraBold",
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: longueurPerCent(10, context),),
              Padding(
                padding:EdgeInsets.all(10),
                child: Text("NB: Les différentes tailles recommandées mentionnées ci-dessous le sont juste à titre indicatif. Elles se basent sur une silhouette régulière.",
                  style: TextStyle(
                    fontSize: 11
                  ),
                ),
              ),
              (nombre==0)? Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(20, context)),
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                              color: Colors.pink,
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom:10),
                                    child: Text(
                                      'T-Shirt',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 40,
                              columns: [
                                DataColumn(label: Container(
                                    child: Text('Poitrine en cm',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),
                                DataColumn(label: Container(
                                    child: Text('Taille recommandée',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),

                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Center(child: Text('78/82'))),
                                  DataCell(Center(child: Text('XS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('82/86'))),
                                  DataCell(Center(child: Text('S',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('86/90'))),
                                  DataCell(Center(child: Text('M',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('90/94'))),
                                  DataCell(Center(child: Text('L',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('94/98'))),
                                  DataCell(Center(child: Text('XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('98/102'))),
                                  DataCell(Center(child: Text('XXL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(20, context),),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                              color:Colors.pink,
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom:10),
                                    child: Text(
                                      'Robes/Combinaisons',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 20,
                              columns: [
                                DataColumn(label: Container(
                                    child: Text('T. de Taille',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),
                                DataColumn(label: Text('Bassin',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),

                                )),
                                DataColumn(label: Text('Taille recommandée',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                )),

                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Center(child: Text('55/59'))),
                                  DataCell(Center(child: Text('84/88'))),
                                  DataCell(Center(child: Text('XS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('59/63'))),
                                  DataCell(Center(child: Text('88/92'))),
                                  DataCell(Center(child: Text('S',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('63/67'))),
                                  DataCell(Center(child: Text('92/96'))),
                                  DataCell(Center(child: Text('M',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('67/71'))),
                                  DataCell(Center(child: Text('96/100'))),
                                  DataCell(Center(child: Text('L',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('71/75'))),
                                  DataCell(Center(child: Text('100/104'))),
                                  DataCell(Center(child: Text('XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('75/79'))),
                                  DataCell(Center(child: Text('104/108'))),
                                  DataCell(Center(child: Text('XXL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(20, context),),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: longueurPerCent(40, context)),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                              color: Colors.pink,
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom:10),
                                    child: Text(
                                      'Jeans/Short/Shorty',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 20,
                              columns: [
                                DataColumn(label: Container(
                                    child: Text('T. de Taille',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),DataColumn(label: Container(
                                    child: Text('Bassin',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),
                                DataColumn(label: Container(
                                    child: Text(' Taille recommandée',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),

                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Center(child: Text('63/67'))),
                                  DataCell(Center(child: Text('92/96'))),
                                  DataCell(Center(child: Text('38',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('67/71'))),
                                  DataCell(Center(child: Text('96/100'))),
                                  DataCell(Center(child: Text('40',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('71/75'))),
                                  DataCell(Center(child: Text('100/104'))),
                                  DataCell(Center(child: Text('42',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('75/79'))),
                                  DataCell(Center(child: Text('104/108'))),
                                  DataCell(Center(child: Text('44',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('79/84'))),
                                  DataCell(Center(child: Text('108/112'))),
                                  DataCell(Center(child: Text('46',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('84/89'))),
                                  DataCell(Center(child: Text('112/116'))),
                                  DataCell(Center(child: Text('48',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]), DataRow(cells: [
                                  DataCell(Center(child: Text('89/94'))),
                                  DataCell(Center(child: Text('116/122'))),
                                  DataCell(Center(child: Text('50',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]), DataRow(cells: [
                                  DataCell(Center(child: Text('94/99'))),
                                  DataCell(Center(child: Text('122/128'))),
                                  DataCell(Center(child: Text('52',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]), DataRow(cells: [
                                  DataCell(Center(child: Text('99/104'))),
                                  DataCell(Center(child: Text('128/134'))),
                                  DataCell(Center(child: Text('54',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]), DataRow(cells: [
                                  DataCell(Center(child: Text('104/109'))),
                                  DataCell(Center(child: Text('134/160'))),
                                  DataCell(Center(child: Text('56',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(height: longueurPerCent(60, context),)
                ],
              ):Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(20, context)),
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                              color: HexColor("#FFC30D"),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom:10),
                                    child: Text(
                                      'T-Shirt/Pollos/Pulls/Jacket',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:HexColor("#001C36")),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 40,
                              columns: [
                                DataColumn(label: Container(
                                    child: Text('Poitrine en cm',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),
                                DataColumn(label: Container(
                                    child: Text('Taille recommandée',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),

                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Center(child: Text('88/92'))),
                                  DataCell(Center(child: Text('S',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('96/100'))),
                                  DataCell(Center(child: Text('M',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('104/108'))),
                                  DataCell(Center(child: Text('L',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('112/116'))),
                                  DataCell(Center(child: Text('XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('120/124'))),
                                  DataCell(Center(child: Text('2XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('128/132'))),
                                  DataCell(Center(child: Text('3XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('136/140'))),
                                  DataCell(Center(child: Text('4XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(20, context),),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                              color: HexColor("#FFC30D"),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom:10),
                                    child: Text(
                                      'Chemise',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: HexColor("#001C36")),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 40,
                              columns: [
                                DataColumn(label: Container(
                                    child: Text('Poitrine en cm',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),
                                DataColumn(label: Container(
                                    child: Text('Taille recommandée',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),

                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Center(child: Text('39/40'))),
                                  DataCell(Center(child: Text('M',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('41/42'))),
                                  DataCell(Center(child: Text('L',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('43/44'))),
                                  DataCell(Center(child: Text('XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('45/46'))),
                                  DataCell(Center(child: Text('2XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('47/48'))),
                                  DataCell(Center(child: Text('3XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('49/50'))),
                                  DataCell(Center(child: Text('4XL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(20, context),),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                              color: HexColor("#FFC30D"),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom:10),
                                    child: Text(
                                      'Jeans',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: HexColor("#001C36")),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 40,
                              columns: [
                                DataColumn(label: Container(
                                    child: Text('Tour de Taille',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),
                                DataColumn(label: Container(
                                    child: Text('Taille recommandée',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ))),

                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Center(child: Text('78/81'))),
                                  DataCell(Center(child: Text('40',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('82-85'))),
                                  DataCell(Center(child: Text('42',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('86-89'))),
                                  DataCell(Center(child: Text('44',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('90-93'))),
                                  DataCell(Center(child: Text('46',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('94-97'))),
                                  DataCell(Center(child: Text('48',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('98-101'))),
                                  DataCell(Center(child: Text('50',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('102-105'))),
                                  DataCell(Center(child: Text('52',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('106-109'))),
                                  DataCell(Center(child: Text('54',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('110-113'))),
                                  DataCell(Center(child: Text('56',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('114-117'))),
                                  DataCell(Center(child: Text('58',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),

                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('118-121'))),
                                  DataCell(Center(child: Text('60',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),


                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('122-125'))),
                                  DataCell(Center(child: Text('62',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Center(child: Text('126-129'))),
                                  DataCell(Center(child: Text('64',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(20, context),),
                  new Container(height: longueurPerCent(60, context),)
                ],
              ),
            ]),
          )),
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
