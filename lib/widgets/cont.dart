import 'package:flutter/material.dart';

class ContainerInfo extends StatelessWidget {
  final btn;
  final txt;
  ContainerInfo(this.btn, this.txt);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          btn,
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 1,
            color: Colors.white,
            height: 35,
          ),
          Spacer(),
          Text(
            txt,
            style: TextStyle(
                fontFamily: 'coves', fontSize: 20, color: Colors.black),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
