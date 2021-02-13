import 'package:flutter/material.dart';

class ContactModel {
  final String name;
  final String cellPhone;
  final String landline;
  final String email;
  final String note;
  bool isFavorite;

  ContactModel({
    @required this.name,
    @required this.cellPhone,
    @required this.landline,
    @required this.email,
    @required this.note,
    this.isFavorite = false,
  });
}
