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
            _simpleList(),
            SizedBox(
              height: 15.00,
            ),
            _simpleListWithDivider(),
          ],
        ),
      ),
    );
  }

  ///  list item
  Widget _item(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('row :  $index'),
    );
  }

  /// simple list
  Widget _simpleList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        return _item(i);
      },
      shrinkWrap: true,
      itemCount: 5,
    );
  }

  ///  list with divider
  Widget _simpleListWithDivider() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int i) {
        return _item(i);
      },
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

