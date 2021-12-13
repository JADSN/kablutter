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

  String fromStatus = "";
  String toStatus = "";
  int currentIndex = 0;

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
                                      if (toStatus != "Todo") {
                                        listStateTodos.removeAt(currentIndex);
                                      }

                                      if (fromStatus == "In progress") {
                                        listStateInProgress
                                            .removeAt(currentIndex);
                                      }

                                      if (fromStatus == "Done") {
                                        listStateDone.removeAt(currentIndex);
                                      }

                                      setState(() {});
                                    },
                                    onDragStarted: () {
                                      setState(() {
                                        fromStatus = "Todo";
                                        currentIndex = index;
                                      });
                                    },
                                  );
                                },
                              ),
                    onAccept: (data) {
                      if (fromStatus != "Todo") {
                        var dataParsed = data! as String;
                        listStateTodos.add(dataParsed);
                      }
                    },
                    onMove: (details) {
                      setState(() {
                        toStatus = "Todo";
                      });
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
                                      if (toStatus != "In progress") {
                                        listStateInProgress
                                            .removeAt(currentIndex);
                                      }

                                      if (fromStatus == "Todo") {
                                        listStateTodos.removeAt(currentIndex);
                                      }

                                      if (fromStatus == "Done") {
                                        listStateDone.removeAt(currentIndex);
                                      }

                                      setState(() {});
                                    },
                                    onDragStarted: () {
                                      setState(() {
                                        fromStatus = "In progress";
                                        currentIndex = index;
                                      });
                                    },
                                  );
                                },
                              ),
                    onAccept: (data) {
                      if (fromStatus != "In progress") {
                        var dataParsed = data! as String;
                        listStateInProgress.add(dataParsed);
                      }
                    },
                    onMove: (details) {
                      setState(() {
                        toStatus = "In progress";
                      });
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
                                      if (toStatus != "Done") {
                                        listStateDone.removeAt(currentIndex);
                                      }

                                      if (fromStatus == "In progress") {
                                        listStateInProgress
                                            .removeAt(currentIndex);
                                      }

                                      if (fromStatus == "Todo") {
                                        listStateTodos.removeAt(currentIndex);
                                      }

                                      setState(() {});
                                    },
                                    onDragStarted: () {
                                      setState(() {
                                        currentIndex = index;
                                        fromStatus = "Done";
                                      });
                                    },
                                    onDragEnd: (details) {},
                                  );
                                },
                              ),
                    onAccept: (data) {
                      if (fromStatus != "Done") {
                        var dataParsed = data! as String;
                        listStateDone.add(dataParsed);
                      }
                    },
                    onMove: (details) {
                      setState(() {
                        toStatus = "Done";
                      });
                    },
                    onLeave: (data) {},
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
