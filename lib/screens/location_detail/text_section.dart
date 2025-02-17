import 'package:flutter/material.dart';
class TextSection extends StatelessWidget {
 final Color _color;// final means once we set it we can not be changed it 
   
    TextSection(this._color);
  @override
  Widget build(BuildContext context) {
    return   Container(
            decoration: BoxDecoration(
              color: _color
            ),
            child: Text(''),  
          );
  }
}