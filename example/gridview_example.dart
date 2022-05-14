import 'package:flutter/material.dart';

class GridExample extends StatefulWidget {
  const GridExample({Key? key}) : super(key: key);

  @override
  State<GridExample> createState() => _GridExampleState();
}

class _GridExampleState extends State<GridExample> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.00),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              return _gridItems(index);
            }, itemCount: 10,),
      ),
    ));
  }

  /// grid items
  Widget _gridItems(int index) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text('Item $index')),
      ),
    );
  }
}
