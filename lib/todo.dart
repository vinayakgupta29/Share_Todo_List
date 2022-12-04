// ignore_for_file: file_names

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    this.id,
    this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true ),
    ];
  }
}