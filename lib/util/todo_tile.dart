import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoflutter/util/constants.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final String taskDesc;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? qrfunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.qrfunction,
    required this.taskDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        closeOnScroll: true,
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            label: "SHARE",
            flex: 2,
            onPressed: qrfunction,
            icon: Icons.qr_code,
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ]),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //delete individual items
            SlidableAction(
              label: 'DELETE',
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade600,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: itemcolor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: checkboxcolor,
              ),
              const Padding(padding: EdgeInsets.only(right: 10.0)),

              // task name
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName.toUpperCase(),
                    style: TextStyle(
                        color: textcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 4),
                  ),
                  Spacer(),
                  Text(
                    taskDesc,
                    style: TextStyle(
                        color: textcolor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 4),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
