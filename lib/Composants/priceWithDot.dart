import 'package:flutter/material.dart';

class PriceWithDot extends StatefulWidget{
  final int price;
  final double size;
  final Color couleur;
  final String police;
  TextDecoration decoration;

  PriceWithDot({
    this.price,
    this.size,
    this.couleur,
    this.police,
    this.decoration
});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PriceWithDotState();
  }
  
}
class PriceWithDotState extends State<PriceWithDot>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(priceWithDot(widget.price) + ' FCFA', textAlign: TextAlign.start, maxLines: 1, style: TextStyle( color: widget.couleur, fontSize: widget.size,
        fontFamily: widget.police, fontWeight: FontWeight.bold, decoration: widget.decoration),);
  }

  String priceWithDot(int price){
    int lengthPrice = price.toString().length;
    String priceWithDot=price.toString();
    if(lengthPrice==4){
      setState(() {
        priceWithDot = priceWithDot[0] + '.' + priceWithDot.substring(1, priceWithDot.length);
      });
      return priceWithDot;
    } else if(lengthPrice==5){
      setState(() {
        priceWithDot = priceWithDot.substring(0, 2) + '.' + priceWithDot.substring(2, 5) ;
      });
      return priceWithDot;
    }else if(lengthPrice==6){
      setState(() {
        priceWithDot = priceWithDot.substring(0, 3) + '.' + priceWithDot.substring(3, 6) ;
      });
      return priceWithDot;
    } else if(lengthPrice==7){
      setState(() {
        priceWithDot = priceWithDot.substring(0, 1) + '.' + priceWithDot.substring(1, 4) + '.' + priceWithDot.substring(4, 7) ;
      });
      return priceWithDot;
    } else
      return priceWithDot;
  }
}