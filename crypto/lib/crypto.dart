import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() {
  runApp(const BitcoinScreen());
}

class BitcoinScreen extends StatelessWidget {
  const BitcoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal[50],
      ),
      home: const MyCryptoPage(),
    );
  }
}

class MyCryptoPage extends StatefulWidget {
  const MyCryptoPage({Key? key}) : super(key: key);

  @override
  State<MyCryptoPage> createState() => _MyCryptoPageState();
}

class _MyCryptoPageState extends State<MyCryptoPage> {
  String select = "aed", description = "", name = "", type = "", unit = "";
  double value = 0.0;
  List<String> exList = [
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Bitcoin cryptocurrency ")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    "\t\t\t\t\t\t\Select fiat or crypto money to \t\t\t\t\t\ display the value exchange",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  itemHeight: 60,
                  value: select,
                  onChanged: (newValue) {
                    setState(() {
                      select = newValue.toString();
                    });
                  },
                  items: exList.map((selectLoc) {
                    return DropdownMenuItem(
                      child: Text(
                        selectLoc,
                      ),
                      value: selectLoc,
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    onPressed: _loadCrypto, child: const Text("load")),
                const SizedBox(height: 18),
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway',
                  ),
                ),
              ],
            ))));
  }

  Future<void> _loadCrypto() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("progress"), title: const Text("Searching...."));
    progressDialog..show();

    var url = Uri.parse("https://api.coingecko.com/api/v3/exchange_rates");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData['rates'][select]['name'];
      unit = parsedData['rates'][select]['unit'];
      value = parsedData['rates'][select]['value'];
      type = parsedData['rates'][select]['type'];

      setState(() {
        description =
            " \n Name: $name \n Unit: $unit \n Value: $value \n Type: $type";
      });
      progressDialog.dismiss();
    }
  }
}
