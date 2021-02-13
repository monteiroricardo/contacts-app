import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final TextFormField textFormField;
  final double h;
  final double w;
  ContainerWidget([this.textFormField, this.h = 43, this.w = 240]);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(3),
        alignment: Alignment.center,
        height: h,
        width: w,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: textFormField);
  }
}
