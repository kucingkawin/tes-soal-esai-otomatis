import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton
{
  static Widget tombolMaterial({String teks, Color warnaTeks, Color warna, FontWeight fontWeight = FontWeight.normal, double elevation = 0.0, bool border = false, void Function() onTap}) {
    return Material(
      shape: border ? RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 2.0)) : null,
      elevation: elevation,
      color: warna,
      child: InkWell(
        child: Container(
          child: Center(
            child: Text(
              teks,
              style: TextStyle(
                color: warnaTeks,
                fontWeight: fontWeight
              ),
            ),
          )
        ),
        onTap: onTap,
      )
    );
  }
}