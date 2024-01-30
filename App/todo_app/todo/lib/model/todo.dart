class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Academic Tasks', isDone: true),
      ToDo(id: '02', todoText: 'Study Sessions', isDone: true),
      ToDo(id: '03', todoText: 'Extracurricular Activities',),
      ToDo(id: '04', todoText: 'Health and Wellness',),
    ];
  }
}