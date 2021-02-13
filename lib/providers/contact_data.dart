import 'package:contacts2/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContatcList with ChangeNotifier {
  List<Map> _contactsList = [];

  int get itemsLength => _contactsList.length;
  List<Map> get contactsList {
    return [..._contactsList];
  }

  List<Map> get contactListFav =>
      _contactsList.where((fav) => fav['isFavorite']).toList();

  addContact(ContactModel c) {
    Map<String, dynamic> contactMap = {};
    contactMap['name'] = c.name;
    contactMap['cellPhone'] = c.cellPhone;
    contactMap['landLine'] = c.landline;
    contactMap['note'] = c.note;
    contactMap['email'] = c.email;
    contactMap['isFavorite'] = c.isFavorite;
    _contactsList.add(contactMap);
    notifyListeners();
  }
}
