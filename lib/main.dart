import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late TextEditingController inputcontrol;
  late FocusNode inputfocus;
  // ignore: non_constant_identifier_names
  late bool has_focus;
  late bool isEnabled;
  late SharedPreferences sharedPreferences;
  late List<String> list;

  @override
  void initState() {
    super.initState();
    inputcontrol = TextEditingController();
    inputfocus = FocusNode();
    has_focus = false;
    isEnabled = false;
    list = [];
    loadSharedPreferencesAndData();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    inputfocus.addListener(() {
      setState(() {
        has_focus = inputfocus.hasFocus;
      });
    });
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "TO-DO-LIST",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.tealAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: list.isEmpty ? emptyList() : buildListView(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: has_focus
                  ? const EdgeInsets.all(18.0)
                  : const EdgeInsets.all(8.0),
              child: ListTile(
                title: TextField(
                  controller: inputcontrol,
                  focusNode: inputfocus,
                  onChanged: (text) {
                    setState(() {
                      isEnabled = ( inputcontrol.text != "");
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter the subject",
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: has_focus ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: isEnabled ? () => addData(inputcontrol) : null,
                  child: const Text("save"),
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }

  Widget emptyList() {
    return const Center(child: Text('No items'));
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(list[index]);
      },
    );
  }

  Widget buildItem(String item) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(
        color: Colors.red[700],
        child: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        ),
      ),
      onDismissed: (direction) => removeData(item),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item),
    );
  }

  Widget buildListTile(String item) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item,
          ),
        ),
        leading: const Icon(Icons.list),
      ),
    );
  }

  void addData(TextEditingController cnt) {
    setState(() {
      list.insert(0, cnt.text);
      saveData();
      cnt.clear();
      isEnabled = false;
    });
  }

  void removeData(String itm) {
    list.remove(itm);
    saveData();
  }

  void loadData() {
    setState(() {
      list = sharedPreferences.getStringList('list')!;
    });
  }

  void saveData() {
    setState(() {
      sharedPreferences.setStringList('list', list);
    });
    //sharedPreferences.setStringList('list', list);
  }
}
