import 'package:flutter/material.dart';

class TagsView extends StatefulWidget {
  const TagsView({Key? key}) : super(key: key);

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  List<ChipsData> _chips = [];

  @override
  void initState() {
    _chips = [
      ChipsData(id: 1, name: 'Java'),
      ChipsData(id: 2, name: 'Kotlin'),
      ChipsData(id: 3, name: 'Dart'),
      ChipsData(id: 4, name: 'Swift'),
      ChipsData(id: 5, name: 'Python'),
      ChipsData(id: 6, name: 'Objective-c'),
      ChipsData(id: 7, name: 'Pascal'),
      ChipsData(id: 8, name: 'C'),
      ChipsData(id: 9, name: 'C++'),
      ChipsData(id: 10, name: 'C#'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.00),
        child: Wrap(
          spacing: 10,
          runSpacing: 10.00,
          children: _chips
              .map((e) => Chip(
                    key: ValueKey(e.id!),
                    label: Text(e.name!),
                    backgroundColor: Colors.amber.shade200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    deleteIconColor: Colors.black,
                    //onDeleted :() => _deleteChip(e.id!),
                  ))
              .toList(),
        ),
      ),
    ));
  }

  void _deleteChip(int id) {
    setState(() {
      _chips.removeWhere((element) => element.id == id);
    });
  }
}

class ChipsData {
  int? id;
  String? name;
  ChipsData({this.id, this.name});
}
