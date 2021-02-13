import 'package:contacts2/providers/contact_data.dart';
import 'package:contacts2/utils/routes.dart';
import 'package:contacts2/views/contact_add_view.dart';
import 'package:contacts2/views/contatc_details_view.dart';
import 'package:contacts2/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContatcList(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.HOME,
        routes: {
          Routes.HOME: (ctx) => HomePage(),
          Routes.CONTATCT_ADD: (ctx) => ContactAddPage(),
          Routes.CONTATCT_DETAILS: (ctx) => ContactDetail(),
        },
      ),
    ),
  );

  SystemChrome.setEnabledSystemUIOverlays([]);
}
