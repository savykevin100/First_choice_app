
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
//import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;


// ignore: must_be_immutable
class FilterTest extends StatefulWidget {
  static String id="FilterTest";
  String genre;
  String titreCategorie;




  @override
  _FilterTestState createState() => _FilterTestState();
}

class _FilterTestState extends State<FilterTest> {

  List<RangeSliderData> rangeSliders;

  ScrollController controller = ScrollController();
  String nameUser;
  bool val = false;
  int nombre;

  bool prix=false;
  String taille;
  bool sizeChekbox=false;
  int prixMax;
  int prixMin;
  String _dropDownValue2;
  String genre;
  String sousCategorie;
  List<Map<String, dynamic>> data = [];
  int nombreAjoutPanier;
  List<String> selectedSizes = <String>[];
  String emptySearch;
  bool loadingSearch=false;
  String noData ;
  List<RadioModel> sampleData = new List<RadioModel>();


  @override
  void initState() {
    super.initState();
    rangeSliders = _rangeSliderDefinitions();
    sampleData.add(new RadioModel(false, 'XS'));
    sampleData.add(new RadioModel(false, 'S',));
    sampleData.add(new RadioModel(false, 'M', ));
    sampleData.add(new RadioModel(false, 'L',));
    sampleData.add(new RadioModel(false, 'XL'));
    sampleData.add(new RadioModel(false, 'XXL',));
    sampleData.add(new RadioModel(false, '28', ));
    sampleData.add(new RadioModel(false, '30',));
    sampleData.add(new RadioModel(false, '32'));
    sampleData.add(new RadioModel(false, '34',));
    sampleData.add(new RadioModel(false, '36', ));
    sampleData.add(new RadioModel(false, '38',));
    sampleData.add(new RadioModel(false, '40'));
    sampleData.add(new RadioModel(false, '42',));
    sampleData.add(new RadioModel(false, '44', ));
    sampleData.add(new RadioModel(false, '46',));
    sampleData.add(new RadioModel(false, '48',));
    sampleData.add(new RadioModel(false, '50',));

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
      backgroundColor: HexColor("#F5F5F5"),
      appBar: AppBar(title: Text('RangeSlider Demo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 0.0),
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text("Price Range"),
                  )
                ]
                 // ..addAll(_buildRangeSliders())
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 0.0),
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              height: longueurPerCent(70, context),
              child:  ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: sampleData.length,
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    splashColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        sampleData.forEach(
                                (element) => element.isSelected = false);
                        sampleData[index].isSelected = true;
                        //size=sampleData[index].buttonText;
                      });
                    },
                    child: new RadioItem(sampleData[index]),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 0.0),
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: largeurPerCent(20, context)),
                      child: Text("Selectionnez le genre:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "MonseraBold"),),
                    ),
                    SizedBox(height: longueurPerCent(10, context),),
                    // Genre list
                    Center(
                      child: Card(
                        child: Container(
                          height: longueurPerCent(50, context),
                          padding: EdgeInsets.only(
                              left: largeurPerCent(10, context),
                              right: largeurPerCent(20, context),
                              top: longueurPerCent(10, context)),
                          child: DropdownButton(
                            underline: Text(""),
                            hint: genre == null
                                ? Text(
                              'Genre',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                                : Text(
                              genre,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            isExpanded: true,
                            iconSize: 40.0,
                            items: ['Hommes', 'Femmes'].map(
                                  (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                    () {
                                  genre = val;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: longueurPerCent(10, context),),

                    // Categorie list
                    Center(
                      child: Card(
                        child: Container(
                          height: longueurPerCent(50, context),
                          padding: EdgeInsets.only(
                              left: largeurPerCent(10, context),
                              right: largeurPerCent(20, context),
                              top: longueurPerCent(10, context)),
                          child: DropdownButton(
                            underline: Text(""),
                            hint: _dropDownValue2 == null
                                ? Text(
                              'Categorie',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                                : Text(
                              _dropDownValue2,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            isExpanded: true,
                            iconSize: 40.0,
                            items: ['ACCESSOIRES', 'CHEMISES', 'T-SHIRT', 'JEANS'].map(
                                  (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                    () {
                                  _dropDownValue2 = val;
                                  sousCategorie = _dropDownValue2;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------
  // Creates a list of RangeSliders, based on their
  // definition and SliderTheme customizations
  // -----------------------------------------------
 /* List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
        setState(() {
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));
      // Add an extra padding at the bottom of each RangeSlider
      children.add(SizedBox(height: 8.0));
    }

    return children;
  }*/

  // -------------------------------------------------
  // Creates a list of RangeSlider definitions
  // -------------------------------------------------
  List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0,
          max: 500000.0,
          lowerValue: 10.0,
          upperValue: 1000.0,
          showValueIndicator: true,
          valueIndicatorMaxDecimals: 0,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red[50],
          valueIndicatorColor: Colors.green),

    ];
  }
}

// ---------------------------------------------------
// Helper class aimed at simplifying the way to
// automate the creation of a series of RangeSliders,
// based on various parameters
//
// This class is to be used to demonstrate the appearance
// customization of the RangeSliders
// ---------------------------------------------------
class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xFF0175c2);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 500,
    this.forceValueIndicator: true,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  // Builds a RangeSlider and customizes the theme
  // based on parameters
  //
  /*Widget build(BuildContext context, frs.RangeSliderCallback callback) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 70.0,
              maxWidth: 70.0,
            ),
            child: Text(lowerValueText),
          ),
          Expanded(

            child: Container(
              margin: EdgeInsets.only(top: 60,),
              child: SliderTheme(
                // Customization of the SliderTheme
                // based on individual definitions
                // (see rangeSliders in _RangeSliderSampleState)
                data: SliderTheme.of(context).copyWith(
                  overlayColor: overlayColor,
                  activeTickMarkColor: activeTickMarkColor,
                  activeTrackColor: activeTrackColor,
                  inactiveTrackColor: inactiveTrackColor,
                  //trackHeight: 8.0,
                  thumbColor: thumbColor,
                  valueIndicatorColor: valueIndicatorColor,
                  showValueIndicator: showValueIndicator
                      ? ShowValueIndicator.always
                      : ShowValueIndicator.onlyForDiscrete,
                ),
                child: frs.RangeSlider(
                  min: min,
                  max: max,
                  lowerValue: lowerValue,
                  upperValue: upperValue,
                  divisions: 500,
                  showValueIndicator: showValueIndicator,
                  valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                  onChanged: (double lower, double upper) {
                    // call
                    callback(lower, upper);
                  },
                ),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 100.0,
              maxWidth: 100.0,
            ),
            child: Text(upperValueText + " F CFA"),
          ),
        ],
      ),
    );
  }*/
}



class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.blueAccent
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.blueAccent
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}
