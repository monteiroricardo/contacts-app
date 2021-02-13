import 'package:contacts2/providers/contact_data.dart';
import 'package:contacts2/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

class ContatcItem extends StatelessWidget {
  final int i;
  ContatcItem(this.i);
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContatcList>(context);
    Future<void> _openLink(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: false, forceSafariVC: false);
      } else {
        Text("Fatal error");
      }
    }

    return Column(
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 57,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://www.seekpng.com/png/full/847-8474751_download-empty-profile.png',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.transparent,
                  ),
                  width: 57,
                ),
                contactProvider.contactsList[i]['isFavorite']
                    ? Positioned(
                        bottom: 7,
                        right: 12,
                        child: Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                          size: 20,
                        ),
                      )
                    : Container()
              ],
            ),
            Container(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contactProvider.contactsList[i]['name'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'coves',
                    ),
                  ),
                  Text(
                    contactProvider.contactsList[i]['cellPhone'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontFamily: 'coves',
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: Tab(
                        icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              Offset(4.0, 24.0),
                              Offset(24.0, 4.0),
                              [
                                Colors.blue[200],
                                Colors.greenAccent,
                              ],
                            );
                          },
                          child: IconButton(
                            onPressed: () {
                              _openLink(
                                  "tel:${contactProvider.contactsList[i]['cellPhone']}");
                            },
                            icon: Icon(
                              Icons.phone,
                              size: 25,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: Tab(
                        icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              Offset(4.0, 24.0),
                              Offset(24.0, 4.0),
                              [
                                Colors.blue[400],
                                Colors.blue[900],
                              ],
                            );
                          },
                          child: IconButton(
                            onPressed: () => _openLink(
                                'https://api.whatsapp.com/send?phone=${'55' + contactProvider.contactsList[i]['cellPhone']}&text=Ol%C3%A1'),
                            icon: Icon(
                              Icons.message,
                              size: 25,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Routes.CONTATCT_DETAILS, arguments: i);
              },
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xffef75b1),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 65),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffef75b1),
            Color(0xff7b92df),
          ])),
          height: 0.5,
          width: double.infinity,
        )
      ],
    );
  }
}
