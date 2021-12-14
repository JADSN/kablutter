import 'package:flutter/material.dart';
import 'package:frontend/utils/random.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var states = ["Todo", "In progress", "Done"];

  var statusList = <String, List<String>>{};

  // List<String>? listStateTodos = [];
  // List<String>? listStateInProgress = [];
  // List<String>? listStateDone = [];

  String fromStatus = "";
  String toStatus = "";
  int currentIndex = 0;

  String newColumnName = "";
  String currentDescription = "";

  String? actionDropDownSelected;

  @override
  void initState() {
    super.initState();

    //* Bootstrap
    for (var state in states) {
      var items = List<String>.generate(3, (_) => getRandomString(5));
      Map<String, List<String>> map = {state: items};
      statusList.addAll(map);
    }

    // listStateTodos = statusList["Todo"];
    // listStateInProgress = statusList["In progress"];
    // listStateDone = statusList["Done"];
  }

  List<Widget> generateStatuses() {
    var statusListKeys = statusList.keys.toList();
    List<Widget> resultList = [];

    for (var key in statusListKeys) {
      List<String>? listOfTasksByKey = statusList[key];
      debugPrint("for");

      Widget item = Expanded(
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
                          "${listOfTasksByKey!.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      Text(
                        key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Add new item'),
                                  content: TextField(
                                    keyboardType: TextInputType.text,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Description'),
                                    onChanged: (String newValue) =>
                                        currentDescription = newValue,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          List<String>? list = statusList[key];
                                          list!.add(currentDescription);
                                        });

                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          child: const Icon(Icons.add)),
                      DropdownButton<String>(
                        value: actionDropDownSelected,
                        icon: const Icon(Icons.more_horiz),
                        elevation: 16,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(color: Colors.transparent),
                        onChanged: (String? newValueDropDropdownSelected) {
                          if (newValueDropDropdownSelected == "Clear") {
                            setState(() => listOfTasksByKey.clear());
                          }
                        },
                        items: <String>[
                          'Clear',
                          'Update title',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: DragTarget(
                builder: (BuildContext context, List<Object?> candidateData,
                        List<dynamic> rejectedData) =>
                    listOfTasksByKey.isEmpty
                        ? Center(
                            child: Text.rich(
                              TextSpan(text: "LIST", children: [
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: "''$key''",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: " "),
                                const TextSpan(text: "IS EMPTY "),
                              ]),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : ListView.builder(
                            key: UniqueKey(),
                            controller: ScrollController(),
                            itemCount: listOfTasksByKey.length,
                            itemBuilder: (_, index) {
                              var item = listOfTasksByKey.elementAt(index);

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
                                  if (fromStatus != toStatus) {
                                    listOfTasksByKey.removeAt(currentIndex);
                                    setState(() {});
                                  }
                                },
                                onDragStarted: () =>
                                    setState(() => fromStatus = key),
                              );
                            },
                          ),
                onAccept: (data) {
                  if (fromStatus != toStatus) {
                    var dataParsed = data! as String;
                    listOfTasksByKey.add(dataParsed);
                  }
                },
                onMove: (details) => setState(() => toStatus = key),
              ),
            ),
          ],
        ),
      );

      resultList.add(item);
    }

    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: statusList.keys.isEmpty
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
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: generateStatuses(),
              ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.grey[350],
        elevation: 0,
        child: const Icon(
          Icons.plus_one,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add Column'),
              content: TextField(
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Column name'),
                onChanged: (String newValue) => newColumnName = newValue,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Map<String, List<String>> map = {newColumnName: []};
                      statusList.addAll(map);
                    });

                    Navigator.pop(context, 'OK');
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
