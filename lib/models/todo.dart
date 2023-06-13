class ToDo {
  String? id;
  String? taskTodo;
  bool? isDone;

  ToDo({this.id, this.taskTodo, this.isDone});

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        taskTodo: 'Bangun menyambut dunia tipu-tipu',
        isDone: false,
      ),
      ToDo(
        id: '2',
        taskTodo: 'Melakukan list kegiatan untuk dunia',
        isDone: false,
      ),
    ];
  }
}
