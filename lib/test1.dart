import 'package:flutter/material.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';

import 'Drawer/Commande/commande_send.dart';

void sucessCallback(response, context) {
  print(response);
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CommandeSend()
    ),
  );

  print("Ça a marché");
}

final kkiapay = KKiaPay(
  amount: 1,
  phone: '61000000',
  data: 'hello world',
  sandbox: true,
  apikey: '5eff6ca0203711eba0637f280536fc17',
  callback: sucessCallback,
  name: 'JOHN DOE',
  theme: "#E30E25",
);

class Test1 extends StatelessWidget {
  static String id="Test1";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kkiapay Sample'),
          centerTitle: true,
        ),
        body: KkiapaySample(),
      ),
    );
  }
}

class KkiapaySample extends StatelessWidget {
  const KkiapaySample({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        minWidth: 250.0,
        height: 60.0,
        child: FlatButton(
          color: Color(0xFFE30E25),
          child: Text(
            'Pay Now',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => kkiapay),
            );
          },
        ),
      ),
    );
  }
}