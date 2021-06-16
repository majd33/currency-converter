import 'package:flutter/material.dart';

Widget ListDown(List<String> items, String value, void onChange(val)){

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (String val){onChange(val);},
      items: items==null?[]:items.map((String val) {
        return DropdownMenuItem(child: Text(val),value: val,);
      }).toList(),
    ),
  );
}