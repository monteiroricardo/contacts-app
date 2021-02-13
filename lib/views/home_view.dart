import 'package:contacts2/providers/contact_data.dart';
import 'package:contacts2/utils/routes.dart';
import 'package:contacts2/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff2d3753),
            title: Text(
              'Sair da aplicação?',
              style: TextStyle(color: Colors.white, fontFamily: ('coves')),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar',
                    style: TextStyle(
                        color: Colors.blue[100], fontFamily: ('coves'))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('Confirmar',
                      style: TextStyle(
                          color: Colors.blue[100], fontFamily: ('coves'))),
                  onPressed: () {
                    SystemNavigator.pop();
                  }),
            ],
          );
        },
      );
    }

    final contactProvider = Provider.of<ContatcList>(context);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          _showMyDialog();
          return true;
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff2d3753),
              Color(0xff3c476a),
              Color(0xff4d587b),
            ],
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      'Contacts',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'coves',
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: contactProvider.itemsLength,
                    itemBuilder: (ctx, i) => ContatcItem(i)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color(0xffef75b1),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.CONTATCT_ADD);
        },
      ),
    );
  }
}
