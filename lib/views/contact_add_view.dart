import 'package:contacts2/models/contact_model.dart';
import 'package:contacts2/providers/contact_data.dart';
import 'package:contacts2/utils/routes.dart';
import 'package:contacts2/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContactAddPage extends StatefulWidget {
  @override
  _ContactAddPageState createState() => _ContactAddPageState();
}

class _ContactAddPageState extends State<ContactAddPage> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff2d3753),
          title: Text(
            'Deixar tela atual?',
            style: TextStyle(color: Colors.white, fontFamily: ('coves')),
          ),
          content: SingleChildScrollView(
            child: Text(
              'Todos dados não salvos serão descartados.',
              style: TextStyle(color: Colors.white, fontFamily: ('coves')),
            ),
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
                  Navigator.of(context).popAndPushNamed(Routes.HOME);
                }),
          ],
        );
      },
    );
  }

  final lStyle =
      TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'coves');
  final transparentBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  final border = OutlineInputBorder();

  final _formSettings = GlobalKey<FormState>();
  bool _value = false;
  final map = Map<String, dynamic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    map['isFavorite'] = _value;
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ContatcList>(context);
    saveForm() {
      bool isValid = _formSettings.currentState.validate();
      if (!isValid) {
        return;
      }
      _formSettings.currentState.save();
      final c = ContactModel(
        name: map['name'],
        cellPhone: map['cellPhone'],
        landline: map['landline'],
        email: map['email'],
        note: map['note'],
        isFavorite: map['isFavorite'],
      );
      list.addContact(c);
      Navigator.of(context).popAndPushNamed(Routes.HOME);
    }

    final maskFormatterCellPhone = new MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
    final maskFormatterPhone = new MaskTextInputFormatter(
        mask: '####-####', filter: {"#": RegExp(r'[0-9]')});

    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () {
          return _showMyDialog();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _showMyDialog(),
                      icon: Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Color(0xffef75b1),
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xffef75b1),
                                Color(0xff7b92df),
                              ]),
                              borderRadius: BorderRadius.circular(70)),
                          child: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70)),
                                height: 122,
                                width: 122,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff3c476a),
                                  child: Container(
                                      height: 115,
                                      width: 115,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(70),
                                        child: Image.network(
                                          'https://www.seekpng.com/png/full/847-8474751_download-empty-profile.png',
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                right: 9,
                                top: 82,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(0),
                                      child: IconButton(
                                          onPressed: () {
                                            print(_value);
                                            setState(() {
                                              _value = !_value;
                                              map['isFavorite'] = _value;
                                            });
                                            print(_value);
                                          },
                                          icon: Tab(
                                            icon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return _value
                                                    ? ui.Gradient.linear(
                                                        Offset(4.0, 24.0),
                                                        Offset(24.0, 4.0),
                                                        [
                                                          Colors.yellowAccent,
                                                          Colors.yellow[600],
                                                        ],
                                                      )
                                                    : ui.Gradient.linear(
                                                        Offset(4.0, 24.0),
                                                        Offset(24.0, 4.0),
                                                        [
                                                          Colors.white,
                                                          Colors.white
                                                        ],
                                                      );
                                              },
                                              child: Icon(
                                                Icons.star_rounded,
                                                size: 35,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Form(
                  key: _formSettings,
                  child: Column(
                    children: [
                      ContainerWidget(
                        TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onSaved: (value) => map['name'] = value,
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              bool isLength = value.trim().length > 15;
                              bool isInvalid = value.trim().length < 3;
                              if (isEmpty || isInvalid || isLength) {
                                return 'Informe um nome válido';
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontFamily: 'coves',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            decoration: InputDecoration(
                                suffixText: '*',
                                suffixStyle: TextStyle(color: Colors.red),
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                border: border,
                                counterStyle: null,
                                counterText: '',
                                errorBorder: transparentBorder,
                                focusedErrorBorder: transparentBorder,
                                disabledBorder: transparentBorder,
                                enabledBorder: transparentBorder,
                                focusedBorder: transparentBorder,
                                labelStyle: lStyle,
                                labelText: ('nome'))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ContainerWidget(
                                TextFormField(
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (value) =>
                                        map['cellPhone'] = value,
                                    validator: (value) {
                                      bool isEmpty = value.trim().isEmpty;

                                      bool isInvalid =
                                          value.trim().length != 15;
                                      if (isEmpty || isInvalid) {
                                        return 'Informe um celular válido';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'coves', fontSize: 16),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    inputFormatters: [maskFormatterCellPhone],
                                    decoration: InputDecoration(
                                        suffixText: '*',
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        contentPadding: EdgeInsets.all(10),
                                        isDense: true,
                                        border: border,
                                        errorBorder: transparentBorder,
                                        enabledBorder: transparentBorder,
                                        disabledBorder: transparentBorder,
                                        focusedErrorBorder: transparentBorder,
                                        focusedBorder: transparentBorder,
                                        labelStyle: lStyle,
                                        labelText: ('celular'))),
                              ),
                              ContainerWidget(
                                TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [maskFormatterPhone],
                                    textInputAction: TextInputAction.next,
                                    onSaved: (value) => value.isEmpty
                                        ? map['landline'] = ''
                                        : map['landline'] = value,
                                    style: TextStyle(
                                        fontFamily: 'coves', fontSize: 16),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        isDense: true,
                                        border: border,
                                        errorBorder: transparentBorder,
                                        enabledBorder: transparentBorder,
                                        disabledBorder: transparentBorder,
                                        focusedErrorBorder: transparentBorder,
                                        focusedBorder: transparentBorder,
                                        labelStyle: lStyle,
                                        labelText: ('telefone'))),
                              ),
                              ContainerWidget(
                                TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (value) => value.isEmpty
                                        ? map['email'] = ''
                                        : map['email'] = value,
                                    style: TextStyle(
                                        fontFamily: 'coves', fontSize: 16),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        isDense: true,
                                        border: border,
                                        errorBorder: transparentBorder,
                                        disabledBorder: transparentBorder,
                                        enabledBorder: transparentBorder,
                                        focusedErrorBorder: transparentBorder,
                                        focusedBorder: transparentBorder,
                                        labelStyle: lStyle,
                                        labelText: ('e-mail'))),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ContainerWidget(
                        TextFormField(
                            textInputAction: TextInputAction.done,
                            onSaved: (value) => value.isEmpty
                                ? map['note'] = ''
                                : map['note'] = value,
                            style: TextStyle(fontFamily: 'coves', fontSize: 16),
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            decoration: InputDecoration(
                                isDense: true,
                                border: border,
                                errorBorder: transparentBorder,
                                disabledBorder: transparentBorder,
                                enabledBorder: transparentBorder,
                                focusedBorder: transparentBorder,
                                focusedErrorBorder: transparentBorder,
                                labelStyle: lStyle,
                                labelText: ('nota'))),
                        115,
                        double.infinity,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          saveForm();
                          print(list.itemsLength);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(colors: [
                                Color(0xffef75b1),
                                Color(0xff7b92df),
                              ])),
                          alignment: Alignment.center,
                          width: 80,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 25,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
