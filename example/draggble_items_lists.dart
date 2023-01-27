// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers, dead_code, avoid_print, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class SampleDemo extends StatefulWidget {
  const SampleDemo({super.key});

  @override
  _SampleDemoState createState() => _SampleDemoState();
}

/// enum for camera sides
enum CameraRackSides { TOP, LEFT, RIGHT, BOTTOM }

class _SampleDemoState extends State<SampleDemo> {

  /// scroll controllers for all list
  final ScrollController _scrollControllerTop = ScrollController();
  final ScrollController _scrollControllerBottom = ScrollController();
  final ScrollController _scrollControllerLeft = ScrollController();
  final ScrollController _scrollControllerRight = ScrollController();


  /// Lists
  List< CustomData> itemsTop = [];
  List<CustomData> itemsLeft = [];
  List<CustomData> itemsRight = [];
  List<CustomData> itemsBottom = [];

  ///
  double _topListWidth = 0, _bottomListWidth = 0, _leftListHeight = 0, _rightListHeight = 0;

  ///
  bool _isDragStart = false;

  bool _isShowExtraSpaceTop = false;
  bool _isShowExtraSpaceLeft = false;
  bool _isShowExtraSpaceRight = false;
  bool _isShowExtraSpaceBottom = false;

  ///
  final double itemWidth = 150;
  final double itemHeight = 100;



  ///
  static const String KEY_TOP = 'top';
  static const String KEY_LEFT = 'left';
  static const String KEY_RIGHT = 'right';
  static const String KEY_BOTTOM = 'bottom';




  // scroll list
  _moveUp(ScrollController _scrollController, double _height) {
    _scrollController.animateTo(_scrollController.offset - _height, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown(ScrollController _scrollController, double _height) {
    _scrollController.animateTo(_scrollController.offset + _height, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveLeft(ScrollController _scrollController, double _width) {
    _scrollController.animateTo(_scrollController.offset - _width, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveRight(ScrollController _scrollController, double _width) {
    _scrollController.animateTo(_scrollController.offset + _width, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  @override
  void initState() {


      itemsTop =[
        CustomData(id: 1 , position: "top" ,row: 1 ),
        CustomData(id: 2 , position: "top" ,row: 1 ),
        CustomData(id: 3 , position: "top" ,row: 1 ),
        CustomData(id: 4 , position: "top" ,row: 1 ),
      ];

      itemsBottom =[
        CustomData(id: 1 , position: "bottom" ,row: 1 ),
        CustomData(id: 2 , position: "bottom" ,row: 1 ),
        CustomData(id: 3 , position: "bottom" ,row: 1 ),
      ];

      itemsRight =[
        CustomData(id: 1 , position: "right" ,row: 1 ),
        CustomData(id: 2 , position: "right" ,row: 1 ),
        CustomData(id: 3 , position: "right" ,row: 1 ),
        CustomData(id: 4 , position: "right" ,row: 1 ),
        CustomData(id: 5 , position: "right" ,row: 1 ),
      ];

      itemsLeft =[
        CustomData(id: 1 , position: "left" ,row: 1 ),
        CustomData(id: 2 , position: "left" ,row: 1 ),
      ];



    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Widget _buildSizedNamedButton(String url, String name, void Function() onPressed) {
      return SizedBox(
          width: itemWidth,
          height: itemHeight,
          // child: new RaisedButton(
          /*color: Colors.deepOrangeAccent,*/
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(width: 0, color: Colors.grey),
                borderRadius: BorderRadius.zero,
              ),
              child:  Container(
                child: Center(child: Text(name,style: const TextStyle(color: Colors.white),)),
              )));
    }




    // get list from index
    List<CustomData> getList(int boardIndex) {
      switch (boardIndex) {
        case 0:
          return itemsTop;
          break;
        case 1:
          return itemsLeft;
          break;
        case 2:
          return itemsRight;
          break;
        case 3:
          return itemsBottom;
          break;
      }
      return itemsBottom;
    }

    // get list position [index]
    getListPosition(int index) {
      switch (index) {
        case 0:
          return KEY_TOP;
          break;
        case 1:
          return KEY_LEFT;
          break;
        case 2:
          return KEY_RIGHT;
          break;
        case 3:
          return KEY_BOTTOM;
          break;
      }
    }

    // accept dragged item
    _doAcceptCard(DraggableCard? draggedTask, TaskIndex location) {
      setState(() {
        _isDragStart = false;
        //_isShowExtraSpace = false;

        _isShowExtraSpaceTop = false;
        _isShowExtraSpaceLeft = false;
        _isShowExtraSpaceRight = false;
        _isShowExtraSpaceBottom = false;
      });
      // from other location
      if (location.boardIndex != draggedTask!.fromLocation.boardIndex) {
        setState(() {
          var toList = getList(location.boardIndex);
          var fromList = getList(draggedTask.fromLocation.boardIndex);

          print(" from board : ${draggedTask.fromLocation.boardIndex}");
          // set positions
          draggedTask.item.position = getListPosition(location.boardIndex)!;

          toList.insert(location.listIndex, draggedTask.item);
          fromList.removeAt(draggedTask.fromLocation.listIndex);
        });
      } else {
        // from same list
        setState(() {
          var tmpList = getList(location.boardIndex);
          if (tmpList.remove(draggedTask.item)) tmpList.insert(location.listIndex, draggedTask.item);
        });
      }
    }

    /// get specif visible list space
    getVisibilitySpace(int boardIndex) {
      switch (boardIndex) {
        case 0:
          return _isShowExtraSpaceTop;
          break;
        case 1:
          return _isShowExtraSpaceLeft;
          break;
        case 2:
          return _isShowExtraSpaceRight;
          break;
        case 3:
          return _isShowExtraSpaceBottom;
          break;
      }
    }


    /// add extra space at end of list
    Widget widgetForExtraSpace(int boardIndex, bool isTop) {
      return Visibility(
          visible: getVisibilitySpace(boardIndex) ?? true,
          child: Container(
              child: DragTarget(builder: (context, List<DraggableCard?> candidateData, rejectedData) {
                return Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    height: itemHeight,
                    width: itemWidth,
                  ),
                );
              }, onWillAccept: (DraggableCard? draggedTask) {
                print("Will accept  extra trailing space");
                return (draggedTask?.fromLocation.boardIndex != boardIndex);
              }, onAccept: (DraggableCard? draggedTask) {
                setState(() {
                  print(" from board : $boardIndex");
                  // set position
                  draggedTask!.item.position = getListPosition(boardIndex)!;

                  if (isTop) {
                    getList(boardIndex).insert(0, draggedTask.item);
                  } else {
                    getList(boardIndex).add(draggedTask.item);
                  }
                  getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                });
              })));
    }

    /// get inner sub item
    Widget getInnerSubItem(int index, TaskIndex location, List<CustomData> _list, bool _isVertical) {
      return Padding(
          padding: (_isVertical ? EdgeInsets.fromLTRB(0, index == 0 ? 0 : 2, 0, 2) : EdgeInsets.fromLTRB(index == 0 ? 0 : 2, 0, 2, 0)),
          child: DragTarget(
            builder: (context, List<DraggableCard?> candidateData, rejectedData) {
              return Container(
                child: LongPressDraggable(
                    feedback: Transform.rotate(
                      angle: 0, // 5 degrees to radians  0.0872665,
                      child: _buildSizedNamedButton('', '${_list[index].id}',() {}),
                    ),
                    childWhenDragging: _buildSizedNamedButton('','', () {}),
                    data: DraggableCard(location, _list[index], itemPos: index),
                    onDragStarted: () {
                      setState(() {
                        _isDragStart = true;
                        //_isShowExtraSpace = true;
                      });
                    },
                    onDragCompleted: () {
                      setState(() {
                        _isDragStart = false;
                        //_isShowExtraSpace = false;
                        _isShowExtraSpaceTop = false;
                        _isShowExtraSpaceLeft = false;
                        _isShowExtraSpaceRight = false;
                        _isShowExtraSpaceBottom = false;
                      });
                    },
                    child: _buildSizedNamedButton('', '${_list[index].id}',() {})),
              );
            },
            onWillAccept: (DraggableCard? draggedTask) {
              print("Top WillAccept view data======= ${location.listIndex} Dragged on index ====${draggedTask!.fromLocation.listIndex}");
              if (location.boardIndex != draggedTask.fromLocation.boardIndex) {
                switch (location.boardIndex) {
                  case 0:
                    _isShowExtraSpaceTop = true;
                    break;
                  case 1:
                    _isShowExtraSpaceLeft = true;
                    break;
                  case 2:
                    _isShowExtraSpaceRight = true;
                    break;
                  case 3:
                    _isShowExtraSpaceBottom = true;
                    break;
                }
              }
              return true;
            },
            onAccept: (DraggableCard? draggedTask) {
              print("inside accept top=== ${draggedTask!.itemPos}");
              _doAcceptCard(draggedTask, location);
            },
          ));
    }


    /// get list item
    Widget getListItem(int index, TaskIndex location, List<CustomData> _list, bool _isVertical) {
      if (index == _list.length) {
        return widgetForExtraSpace(location.boardIndex, false);
      }

      if (index == 0) {
        return _isVertical
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [widgetForExtraSpace(location.boardIndex, true), getInnerSubItem(index, location, _list, _isVertical)],
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [widgetForExtraSpace(location.boardIndex, true), getInnerSubItem(index, location, _list, _isVertical)],
        );
      }

      return getInnerSubItem(index, location, _list, _isVertical);
    }

    var _top = Container(
      margin: const EdgeInsets.fromLTRB(5, 2, 0, 1),
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollControllerTop,
        shrinkWrap: true,
        itemCount: itemsTop.length + 1,

        /// for dummy space at last
        itemBuilder: (BuildContext context, int index) {
          TaskIndex location = TaskIndex(CameraRackSides.TOP.index, index);
          return getListItem(index, location, itemsTop, false);
        },
      ),
    );

    var _middleViews = Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Container(
                    width: itemWidth,
                    margin: const EdgeInsets.fromLTRB(0, 1, 5, 3),
                    child: Stack(children: [
                      LayoutBuilder(builder: (context, constraints) {
                        _leftListHeight = constraints.maxHeight;
                       print("left list height === $_leftListHeight");
                        return Stack(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _scrollControllerLeft,
                              shrinkWrap: true,
                              itemCount: itemsLeft.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                TaskIndex location = TaskIndex(CameraRackSides.LEFT.index, index);
                                return getListItem(index, location, itemsLeft, true);
                              }),
                          (itemsLeft.length * itemHeight) > _leftListHeight
                              ? const SizedBox()
                              : Align(
                              alignment: Alignment.bottomCenter,
                              child: DragTarget(
                                builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                                  width: itemWidth,
                                  height: _leftListHeight - ((itemsLeft.length * itemHeight) + 10),
                                  color: Colors.transparent,
                                ),
                                onWillAccept: (DraggableCard? draggedTask) {
                                  return (draggedTask?.fromLocation.boardIndex != 1);
                                },
                                onAccept: (DraggableCard? draggedTask) {
                                  setState(() {
                                    draggedTask?.item.position = getListPosition(1)!;
                                    getList(1).add(draggedTask!.item);
                                    getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                                  });
                                },
                              ))
                        ]);
                      }),
                      !_isDragStart
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.topCenter,
                        child: DragTarget(
                          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                            height: 10,
                            width: itemWidth,
                            color: Colors.transparent,
                          ),
                          onWillAccept: (DraggableCard? draggedTask) {
                            print("will accept == Up");
                            setState(() {
                              _moveUp(_scrollControllerLeft, _leftListHeight);
                            });

                            return false;
                          },
                        ),
                      ),
                      !_isDragStart
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.bottomCenter,
                        child: DragTarget(
                          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                            height: 10,
                            width: itemWidth,
                            color: Colors.transparent,
                          ),
                          onWillAccept: (DraggableCard? draggedTask) {
                            print("will accept == Down");
                            setState(() {
                              _moveDown(_scrollControllerLeft, _leftListHeight);
                            });

                            return false;
                          },
                        ),
                      )
                    ]))),
            Container(height: double.infinity, width: 7, color: const Color(0xffD6D6D6)),
            Flexible(
                child: Container(
                    width: itemWidth,
                    margin: const EdgeInsets.fromLTRB(5, 1, 0, 3),
                    child: Stack(children: [
                      LayoutBuilder(builder: (context, constraints) {
                        _rightListHeight = constraints.maxHeight;
                        return Stack(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _scrollControllerRight,
                              shrinkWrap: true,
                              itemCount: itemsRight.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                TaskIndex location = TaskIndex(CameraRackSides.RIGHT.index, index);
                                return getListItem(index, location, itemsRight, true);
                              }),
                          (itemsRight.length * itemHeight) > _rightListHeight
                              ? const SizedBox()
                              : Align(
                              alignment: Alignment.bottomCenter,
                              child: DragTarget(
                                builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                                  width: itemWidth,
                                  height: _rightListHeight - ((itemsRight.length * itemHeight) + 10),
                                  color: Colors.transparent,
                                ),
                                onWillAccept: (DraggableCard? draggedTask) {
                                  return (draggedTask!.fromLocation.boardIndex != 2);
                                },
                                onAccept: (DraggableCard? draggedTask) {
                                  setState(() {
                                    draggedTask!.item.position = getListPosition(2)!;
                                    getList(2).add(draggedTask.item);
                                    getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                                  });
                                },
                              ))
                        ]);
                      }),
                      !_isDragStart
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.topCenter,
                        child: DragTarget(
                          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                            height: 10,
                            width: itemWidth,
                            color: Colors.transparent,
                          ),
                          onWillAccept: (DraggableCard? draggedTask) {
                           print("will accept == Up");
                            setState(() {
                              _moveUp(_scrollControllerRight, _rightListHeight);
                            });

                            return false;
                          },
                        ),
                      ),
                      !_isDragStart
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.bottomCenter,
                        child: DragTarget(
                          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                            height: 10,
                            width: itemWidth,
                            color: Colors.transparent,
                          ),
                          onWillAccept: (DraggableCard? draggedTask) {
                           print("will accept == Down");
                            setState(() {
                              _moveDown(_scrollControllerRight, _rightListHeight);
                            });
                            return false;
                          },
                        ),
                      )
                    ]))),
          ],
        ),
      ),
    );

    var _bottom = Container(
        margin: const EdgeInsets.fromLTRB(5, 2, 0, 1),
        height: itemHeight,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollControllerBottom,
            itemCount: itemsBottom.length + 1,
            // for dummy space at last
            itemBuilder: (BuildContext context, int index) {
              TaskIndex location = TaskIndex(CameraRackSides.BOTTOM.index, index);
              return getListItem(index, location, itemsBottom, false);
            }));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color(0xffFFFFFF),
              padding: const EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(children: [
                    LayoutBuilder(builder: (context, constraints) {
                      _topListWidth = constraints.maxWidth;
                      print("top list length == $_bottomListWidth");
                      return Stack(
                        children: [
                          _top,
                          (itemsTop.length * itemWidth) > _topListWidth
                              ? const SizedBox()
                              : Align(
                              alignment: Alignment.centerRight,
                              child: DragTarget(
                                builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                                  height: 100,
                                  width: _topListWidth - ((itemsTop.length * itemWidth) + 10),
                                  color: Colors.transparent,
                                ),
                                onWillAccept: (DraggableCard? draggedTask) {
                                  return (draggedTask?.fromLocation.boardIndex != 0);
                                },
                                onAccept: (DraggableCard? draggedTask) {
                                  setState(() {
                                    draggedTask?.item.position = getListPosition(0)!;
                                    getList(0).add(draggedTask!.item);
                                    getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                                  });
                                },
                              ))
                        ],
                      );
                    }),
                    !_isDragStart
                        ? const SizedBox()
                        : Align(
                      alignment: Alignment.topRight,
                      child: DragTarget(
                        builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                          height: 100,
                          width: 10,
                          color: Colors.transparent,
                        ),
                        onWillAccept: (DraggableCard? draggedTask) {
                          print("will accept == Right");
                          setState(() {
                            _moveRight(_scrollControllerTop, _topListWidth);
                          });

                          return false;
                        },
                      ),
                    ),
                    !_isDragStart
                        ? const SizedBox()
                        : Align(
                      alignment: Alignment.topLeft,
                      child: DragTarget(
                        builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                          height: 100,
                          width: 10,
                          color: Colors.transparent,
                        ),
                        onWillAccept: (DraggableCard? draggedTask) {
                          print("will accept == Left");
                          setState(() {
                            _moveLeft(_scrollControllerTop, _topListWidth);
                          });

                          return false;
                        },
                      ),
                    )
                  ]),
                  Container(margin: const EdgeInsets.fromLTRB(0, 2, 0, 0), height: 7, color: const Color(0xffD6D6D6)),
                  _middleViews,
                  Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 2), height: 7, color: const Color(0xffD6D6D6)),
                  Stack(children: [
                    LayoutBuilder(builder: (context, constraints) {
                      _bottomListWidth = constraints.maxWidth;
                      print("bottom list length == $_bottomListWidth");
                      return Stack(
                        children: [
                          _bottom,
                          (itemsBottom.length * itemWidth) > _bottomListWidth
                              ? const SizedBox()
                              : Align(
                              alignment: Alignment.centerRight,
                              child: DragTarget(
                                builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                                  height: itemHeight,
                                  width: _bottomListWidth - ((itemsBottom.length * itemWidth) - 10),
                                  color: Colors.transparent,
                                ),
                                onWillAccept: (DraggableCard? draggedTask) {
                                  print("Will accept : bottom : space");
                                  return (draggedTask!.fromLocation.boardIndex != 3);
                                },
                                onAccept: (DraggableCard? draggedTask) {
                                  setState(() {
                                    draggedTask!.item.position = getListPosition(3)!;
                                    getList(3).add(draggedTask.item);
                                    getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                                  });
                                },
                              ))
                        ],
                      );
                    }),
                    !_isDragStart
                        ? const SizedBox()
                        : Align(
                      alignment: Alignment.bottomRight,
                      child: DragTarget(
                        builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                          height: 100,
                          width: 10,
                          color: Colors.transparent,
                        ),
                        onWillAccept: (DraggableCard? draggedTask) {
                          print("will accept == Right");
                          setState(() {
                            _moveRight(_scrollControllerBottom, _bottomListWidth);
                          });

                          return false;
                        },
                      ),
                    ),
                    !_isDragStart
                        ? const SizedBox()
                        : Align(
                      alignment: Alignment.bottomLeft,
                      child: DragTarget(
                        builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                          height: 100,
                          width: 10,
                          color: Colors.transparent,
                        ),
                        onWillAccept: (DraggableCard? draggedTask) {
                          print("will accept == Left");
                          setState(() {
                            _moveLeft(_scrollControllerBottom, _bottomListWidth);
                          });

                          return false;
                        },
                      ),
                    )
                  ])
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/// custom data
class CustomData {
  int id;
  String position;
  int row;

  CustomData( {required this.id,
    required this.position,
    required this.row,
    });
}

/// for maintain card data
class TaskIndex {
  final int boardIndex;
  final int listIndex;

  TaskIndex(this.boardIndex, this.listIndex);

  bool operator (TaskIndex other) {
    return boardIndex == other.boardIndex && listIndex == other.listIndex;
  }
}

///DraggableCard class
class DraggableCard {
  TaskIndex fromLocation;
  CustomData item;
  int itemPos;

  DraggableCard(this.fromLocation, this.item, {required this.itemPos});
}
