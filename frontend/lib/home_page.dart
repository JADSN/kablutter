import 'package:flutter/material.dart';
import 'package:frontend/utils/random.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var states = ["Todo", "In progress", "Done"];

  var lists = <String, dynamic>{};

  List<String> listStateTodos = [];
  List<String> listStateInProgress = [];
  List<String> listStateDone = [];

  // var currentIndex = 0;
  // var currentState = "";

  var fromStatus = "";
  var toStatus = "";
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();

    for (var state in states) {
      var items = List<String>.generate(3, (_) => getRandomString(5));
      Map<String, dynamic> map = {state: items};
      lists.addAll(map);
    }

    listStateTodos = lists["Todo"];
    listStateInProgress = lists["In progress"];
    listStateDone = lists["Done"];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //* List To do
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Chip(
                                label: Text(
                              "${listStateTodos.length}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          const Text(
                            "To do",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          InkWell(child: Icon(Icons.add)),
                          InkWell(child: Icon(Icons.more_horiz))
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DragTarget(
                    builder: (BuildContext context, List<Object?> candidateData,
                            List<dynamic> rejectedData) =>
                        listStateTodos.isEmpty
                            ? const Center(
                                child: Text(
                                  "EMPTY LIST",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                key: UniqueKey(),
                                itemCount: listStateTodos.length,
                                itemBuilder: (_, index) {
                                  var item = listStateTodos.elementAt(index);

                                  return Draggable(
                                    maxSimultaneousDrags: 1,
                                    data: item,
                                    feedback: Card(
                                      elevation: 0,
                                      color: Colors.grey[350],
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(item),
                                    ),
                                    onDragCompleted: () {
                                      debugPrint("To do - onDragCompleted");

                                      debugPrint(
                                          "To do currentIndex: $currentIndex");
                                      debugPrint(
                                          "To do fromStatus: $fromStatus");

                                      if (fromStatus == "Todo") {
                                        setState(() {
                                          listStateTodos.removeAt(currentIndex);
                                        });
                                      }

                                      if (fromStatus == "In progress") {
                                        setState(() {
                                          listStateInProgress
                                              .removeAt(currentIndex);
                                        });
                                      }

                                      if (fromStatus == "Done") {
                                        setState(() {
                                          listStateDone.removeAt(currentIndex);
                                        });
                                      }
                                    },
                                    onDragStarted: () {
                                      debugPrint("To do - onDragStarted");

                                      setState(() {
                                        fromStatus = "Todo";
                                        currentIndex = index;
                                      });
                                    },
                                    onDragEnd: (details) {
                                      debugPrint("To do - onDragEnd");
                                    },
                                  );
                                },
                              ),
                    onAccept: (data) {
                      debugPrint("To do - onAccept");

                      var dataParsed = data! as String;
                      listStateTodos.add(dataParsed);
                    },
                    onMove: (details) {
                      debugPrint("To do - onMove");
                    },
                    onLeave: (data) {
                      debugPrint("To do - onLeave");
                    },
                  ),
                ),
              ],
            ),
          ),

          //* List In progress
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Chip(
                                label: Text(
                              "${listStateInProgress.length}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          const Text(
                            "In progress",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          InkWell(child: Icon(Icons.add)),
                          InkWell(child: Icon(Icons.more_horiz))
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DragTarget(
                    builder: (BuildContext context, List<Object?> candidateData,
                            List<dynamic> rejectedData) =>
                        listStateInProgress.isEmpty
                            ? const Center(
                                child: Text(
                                  "EMPTY LIST",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                key: UniqueKey(),
                                itemCount: listStateInProgress.length,
                                itemBuilder: (_, index) {
                                  var item =
                                      listStateInProgress.elementAt(index);

                                  return Draggable(
                                    data: item,
                                    maxSimultaneousDrags: 1,
                                    feedback: Card(
                                      elevation: 0,
                                      color: Colors.grey[350],
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(item),
                                    ),
                                    onDragCompleted: () {
                                      debugPrint("currentIndex: $currentIndex");
                                      debugPrint("fromStatus: $fromStatus");

                                      if (fromStatus == "In progress") {
                                        setState(() {
                                          listStateInProgress
                                              .removeAt(currentIndex);
                                        });
                                      }

                                      if (fromStatus == "Todo") {
                                        setState(() {
                                          listStateTodos.removeAt(currentIndex);
                                        });
                                      }

                                      if (fromStatus == "Done") {
                                        setState(() {
                                          listStateDone.removeAt(currentIndex);
                                        });
                                      }
                                    },
                                    onDragStarted: () {
                                      debugPrint("In Progress - onDragStarted");

                                      setState(() {
                                        fromStatus = "In progress";
                                        currentIndex = index;
                                      });
                                    },
                                    onDragEnd: (details) {
                                      debugPrint("In Progress - onDragEnd");
                                    },
                                  );
                                },
                              ),
                    onAccept: (data) {
                      var dataParsed = data! as String;
                      listStateInProgress.add(dataParsed);
                    },
                    onMove: (details) {
                      debugPrint("In Progres - onMove");
                    },
                    onLeave: (data) {
                      debugPrint("In Progres - onLeave");
                    },
                  ),
                ),
              ],
            ),
          ),

          //* List Done
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Chip(
                                label: Text(
                              "${listStateDone.length}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          const Text(
                            "Done",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          InkWell(child: Icon(Icons.add)),
                          InkWell(child: Icon(Icons.more_horiz))
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DragTarget(
                    builder: (BuildContext context, List<Object?> candidateData,
                            List<dynamic> rejectedData) =>
                        listStateDone.isEmpty
                            ? const Center(
                                child: Text(
                                  "EMPTY LIST",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                key: UniqueKey(),
                                itemCount: listStateDone.length,
                                itemBuilder: (_, index) {
                                  var item = listStateDone.elementAt(index);

                                  return Draggable(
                                    data: item,
                                    maxSimultaneousDrags: 1,
                                    feedback: Card(
                                      elevation: 0,
                                      color: Colors.grey[350],
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(item),
                                    ),
                                    onDragCompleted: () {
                                      debugPrint("Done - onDragCompleted");

                                      debugPrint("currentIndex: $currentIndex");
                                      debugPrint("fromStatus: $fromStatus");

                                      if (fromStatus == "Done") {
                                        setState(() {
                                          listStateDone.removeAt(currentIndex);
                                        });
                                      }

                                      if (fromStatus == "In progress") {
                                        setState(() {
                                          listStateInProgress
                                              .removeAt(currentIndex);
                                        });
                                      }

                                      if (fromStatus == "Todo") {
                                        setState(() {
                                          listStateTodos.removeAt(currentIndex);
                                        });
                                      }
                                    },
                                    onDragStarted: () {
                                      debugPrint("Done - onDragStarted");

                                      setState(() {
                                        currentIndex = index;
                                        fromStatus = "Done";
                                      });
                                    },
                                    onDragEnd: (details) {
                                      debugPrint("Done - onDragEnd");
                                    },
                                  );
                                },
                              ),
                    onAccept: (data) {
                      var dataParsed = data! as String;

                      listStateDone.add(dataParsed);
                    },
                    onMove: (details) {
                      debugPrint("Done - onMove");
                    },
                    onLeave: (data) {
                      debugPrint("Done - onLeave");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
