import 'package:flutter/material.dart';

class SimpleScrollContainer extends StatefulWidget {
  const SimpleScrollContainer() ;

  @override
  _SimpleScrollContainerState createState() => _SimpleScrollContainerState();
}

class _SimpleScrollContainerState extends State<SimpleScrollContainer> {

  List<String> _list = [];
  @override
  void initState() {

    _list =[
       "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
      "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
      "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
      "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
      "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
      "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
      "Hey","Hello" , "Pardon" ,"appetite" , "bon appetite",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _list.map((e) => _innerRow(e.toString())).toList()
            ),
          ),
       ),
    );
  }

  /// inner row
  Widget _innerRow(String name) => Row( children: [ Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text('$name',style: TextStyle(fontWeight: FontWeight.w600),),
  )],);
}

