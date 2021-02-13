import 'package:contacts2/providers/contact_data.dart';
import 'package:contacts2/widgets/cont.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetail extends StatefulWidget {
  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    Future<void> _openLink(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: false, forceSafariVC: false);
      } else {
        Text("Fatal error");
      }
    }

    final element = Provider.of<ContatcList>(context).contactsList;
    final i = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(30),
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
                                        onPressed: () {},
                                        icon: Tab(
                                          icon: ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (Rect bounds) {
                                              return element[i]['isFavorite']
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
                                                        Colors.transparent,
                                                        Colors.transparent
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
              Text(
                element[i]['name'],
                style: TextStyle(
                    fontFamily: 'coves', fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  ContainerInfo(
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      onPressed: () =>
                          _openLink("tel:${element[i]['cellPhone']}"),
                    ),
                    element[i]['cellPhone'],
                  ),
                  element[i]['landLine'] != ''
                      ? ContainerInfo(
                          IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            onPressed: () =>
                                _openLink("tel:${element[i]['cellPhone']}"),
                          ),
                          element[i]['landLine'],
                        )
                      : Container(),
                  ContainerInfo(
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        color: Colors.blue,
                      ),
                      onPressed: () => _openLink(
                          "https://api.whatsapp.com/send?phone=${'55' + element[i]['cellPhone']}&text=Ol%C3%A1"),
                    ),
                    element[i]['cellPhone'],
                  ),
                  element[i]['email'] != ''
                      ? ContainerInfo(
                          IconButton(
                            icon: Icon(
                              Icons.email,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                _openLink("mailto:${element[i]['email']}"),
                          ),
                          element[i]['email'],
                        )
                      : Container(),
                  element[i]['note'] != ''
                      ? ContainerInfo(
                          IconButton(
                            icon: Icon(
                              Icons.sticky_note_2,
                              color: Colors.yellow,
                            ),
                            onPressed: () {},
                          ),
                          element[i]['note'],
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
