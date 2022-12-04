// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:to_do_list/screen/GenerateQr.dart';
import '../todo.dart';
import '../constants/colors.dart';
import 'package:popup_card/popup_card.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          widget.onToDoChanged(widget.todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          widget.todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          widget.todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdBlue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(children: [
            IconButton(onPressed: widget.onDeleteItem(widget.todo.id),
                icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GenerateQR()),
              );
            },
                icon: const Icon(Icons.qr_code))
          ],),
        ),
      ),
    );
  }
}

