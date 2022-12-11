import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../util/constants.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever open in the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _titlecontroller = TextEditingController();
  final _desccontroller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_titlecontroller.text.toUpperCase(), false, _desccontroller.text]);
      _titlecontroller.clear();
      _desccontroller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titlecontroller: _titlecontroller,
          desccontroller: _desccontroller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(), 
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttoncolor,
        foregroundColor: Colors.black,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 40.0, left: 30.0, right: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30.0,
                      child: Icon(
                        Icons.checklist_rounded,
                        size: 45.0,
                        color: textcolor,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "ToDo's",
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        color: textcolor,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${db.toDoList.length} Tasks',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: textcolor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                //deletes all items
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          db.toDoList.clear();
                        });
                        db.updateDataBase();
                      },
                      icon: const Icon(Icons.delete_forever_rounded),
                      color: Colors.red.shade600,
                      iconSize: 50,
                      splashColor: Colors.red,
                    ),
                    const Text('DELETE ALL',style: TextStyle(color: textcolor),)
                  ],
                )
              ],
            ),
          ),
          Expanded(child: Container(child: _taskList())),
        ],
      ),
    );
  }

  Widget _taskList() {
    return ListView.builder(
      itemCount: db.toDoList.length,
      itemBuilder: (context, index) {
        return ToDoTile(
          taskName: db.toDoList[index][0],
          taskCompleted: db.toDoList[index][1],
          taskDesc: db.toDoList[index][2],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),

          //generates the qr code
          qrfunction: (context) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SizedBox(
                height: 200,
                width: 200,
                child: QrImage(
                  data: db.toDoList[index][0]+"\n "+db.toDoList[index][2],
                ),
              ),
            ),
          ), 
        );
      },
    );
  }
}
