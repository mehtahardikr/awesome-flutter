import 'package:flutter/material.dart';

class SimpleDemoNew extends StatefulWidget {
  const SimpleDemoNew();

  @override
  _SimpleDemoNewState createState() => _SimpleDemoNewState();
}

class _SimpleDemoNewState extends State<SimpleDemoNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Column(
           children: [
             ListView.builder(itemBuilder: (BuildContext context , int i){
                   return _item(i);
             } , shrinkWrap: true, itemCount: 5,),
           ],
         ),
       ),
    );
  }

  ///  list item
  Widget _item( int index)  {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('row :  $index'),
      );
  }

}
