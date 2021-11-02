import 'package:flutter/material.dart';

class SampleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child:MaterialButton(
      child: Text('Hello' , style: TextStyle(color: Colors.white),),
      color: Colors.green,
      onPressed: () {
          print(' button tapped');
      },
    ));
  }
}
