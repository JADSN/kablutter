import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var states = ["Todo", "In progress", "Done"];

    var items = List<String>.generate(3, (int index) => "Item ${index}");

    var lists = <String, dynamic>{};

    for (var state in states) {
      lists[state] = items;
    }

    List<String> listStateTodos = lists["Todo"];
    List<String> listStateInProgress = lists["In progress"];
    List<String> listStateDone = lists["Done"];

    return Material(
        child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                  child: ListView.builder(
                    itemCount: listStateTodos.length,
                    itemBuilder: (context, index) {
                      var item = listStateTodos.elementAt(index);

                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
                  child: ListView.builder(
                    itemCount: listStateInProgress.length,
                    itemBuilder: (context, index) {
                      var item = listStateInProgress.elementAt(index);

                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
                  child: ListView.builder(
                    itemCount: listStateDone.length,
                    itemBuilder: (context, index) {
                      var item = listStateDone.elementAt(index);

                      return ListTile(
                        title: Text(item),
                      );
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
