
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late TextEditingController inputControl;
//   late FocusNode inputFocus;
//   late bool hasFocus;
//   late bool isEnabled;
//   late DatabaseHelper dbHelper;
//   late List<Task> taskList;
//
//   @override
//   void initState() {
//     super.initState();
//     inputControl = TextEditingController();
//     inputFocus = FocusNode();
//     hasFocus = false;
//     isEnabled = false;
//     dbHelper = DatabaseHelper();
//     taskList = [];
//     loadTasks();
//   }
//
//   void loadTasks() async {
//     taskList = await dbHelper.getTasks();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     inputFocus.addListener(() {
//       setState(() {
//         hasFocus = inputFocus.hasFocus;
//       });
//     });
//     return MaterialApp(
//       home: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               "TO-DO-LIST",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             backgroundColor: Colors.tealAccent,
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: taskList.isEmpty ? emptyList() : buildListView(),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: hasFocus
//                       ? const EdgeInsets.all(18.0)
//                       : const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: TextField(
//                       controller: inputControl,
//                       focusNode: inputFocus,
//                       onChanged: (text) {
//                         setState(() {
//                           isEnabled = (inputControl.text != "");
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         hintText: "Enter the subject",
//                       ),
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(
//                         color: hasFocus ? Colors.blue : Colors.transparent,
//                         width: 2,
//                       ),
//                     ),
//                     trailing: ElevatedButton(
//                       onPressed: isEnabled
//                           ? () => addData(inputControl)
//                           : null,
//                       child: const Text("save"),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget emptyList() {
//     return const Center(child: Text('No items'));
//   }
//
//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: taskList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return buildItem(taskList[index].title);
//       },
//     );
//   }
//
//   Widget buildItem(String item) {
//     return Dismissible(
//       key: Key('${item.hashCode}'),
//       background: Container(
//         color: Colors.red[700],
//         child: const Padding(
//           padding: EdgeInsets.only(left: 8.0),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 20),
//               child: Icon(
//                 Icons.delete,
//                 color: Colors.white,
//                 size: 36,
//               ),
//             ),
//           ),
//         ),
//       ),
//       onDismissed: (direction) => removeData(item),
//       direction: DismissDirection.startToEnd,
//       child: buildListTile(item),
//     );
//   }
//
//   Widget buildListTile(String item) {
//     return Card(
//       child: ListTile(
//         title: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             item,
//           ),
//         ),
//         leading: const Icon(Icons.list),
//       ),
//     );
//   }
//
//   void addData(TextEditingController cnt) async {
//     final task = {
//       'title': cnt.text,
//     };
//     await dbHelper.insertTask(task);
//     cnt.clear();
//     isEnabled = false;
//     loadTasks();
//   }
//
//   void removeData(String itm) async {
//     final taskId = taskList.firstWhere((task) => task.title == itm).id;
//     await dbHelper.deleteTask(taskId);
//     loadTasks();
//   }
// }
//
//
// class Task {
//   final int id;
//   final String title;
//
//   Task({
//     required this.id,
//     required this.title,
//   });
// }
//
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//
//   factory DatabaseHelper() => _instance;
//
//   DatabaseHelper._internal();
//
//   static Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) return _database;
//
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'my_database.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE tasks(
//             id INTEGER PRIMARY KEY,
//             title TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<void> insertTask(Map<String, dynamic> row) async {
//     final db = await database;
//     await db?.insert('tasks', row);
//   }
//
//   Task taskFromMap(Map<String, dynamic> map) {
//     return Task(
//       id: map['id'],
//       title: map['title'],
//     );
//   }
//
//   Future<List<Task>> getTasks() async {
//     final db = await database;
//     final tasks = await db!.query('tasks');
//
//     return tasks.map((taskMap) => taskFromMap(taskMap)).toList();
//   }
//
//   Future<void> deleteTask(int id) async {
//     final db = await database;
//     await db?.delete('tasks', where: 'id = ?', whereArgs: [id]);
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'dart:async';
void main() {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:'/',
      routes: {
        '/list':(_)=>const Lists(),
        '/':(_)=>const LoginPage(),
      },
    );
  }
}
class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListState();
}

class _ListState extends State<Lists> {
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      }, child: const Text("LOGOUT"),
                    ),
                  ),
                ],
                title: const Text(
                  "TO-DO-LIST",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController username=TextEditingController();

  final TextEditingController password=TextEditingController();
  String errorMessage = '';



  void validateLogin() {
    if (username.text == 'gajendra' && password.text == 'gaja@123') {
      Navigator.of(context).pushReplacementNamed(
        '/list',
      );
    } else {
      // Invalid login, set an error message
      setState(() {
        errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icon(Icons.person),
                ),
                controller: username,
              ),
              const SizedBox(height: 20.0),
              TextField(
                obscureText: true, // Hide password
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  errorText: errorMessage.isNotEmpty ? errorMessage : null,
                ),
                controller: password,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  validateLogin();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
