import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/widgets/todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> todoList = ToDo.todoList();
  List<ToDo> foundTodo = [];
  bool isEdit = false;
  ToDo current = ToDo();
  TextEditingController addTodoC = TextEditingController();

  final searchTodoC = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    foundTodo = todoList;
    searchTodoC.addListener(_handleSearchTodo);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    addTodoC.dispose();
    searchTodoC.dispose();
    super.dispose();
  }

  void _handleSearchTodo() {
    List<ToDo> result = [];
    setState(() {
      searchTodoC.text.isEmpty
          ? result = todoList
          : result = foundTodo
              .where((element) => element.taskTodo!
                  .toLowerCase()
                  .contains(searchTodoC.text.toLowerCase()))
              .toList();

      foundTodo = result;
    });
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _handleTodoEdit(ToDo todo) {
    setState(() {
      isEdit = true;
      addTodoC.text = todo.taskTodo!;
      current = todo;
    });
  }

  void _handleTodoUpdate() {
    setState(() {
      for (var e in foundTodo) {
        if (e.id == current.id) {
          e.taskTodo = addTodoC.text;
        }
      }
    });
    addTodoC.clear();
    isEdit = false;
  }

  void _handleDeleteTodo(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _handleAddNewToDo() {
    setState(() {
      addTodoC.text.isNotEmpty
          ? todoList.insert(
              0,
              ToDo(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                taskTodo: addTodoC.text,
                isDone: false,
              ))
          : showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Warning ... !'),
                content: const Text(
                  'Input new to do is empty!',
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Okay!'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
    });
    addTodoC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              size: 30,
              color: Colors.black,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    controller: searchTodoC,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: const Text(
                    'All ToDos',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: foundTodo
                        .map((e) => ToDoItem(
                              todoChanged: _handleTodoChange,
                              todoDeleted: _handleDeleteTodo,
                              todoEdit: _handleTodoEdit,
                              todo: e,
                            ))
                        .toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: TextField(
                              controller: addTodoC,
                              decoration: const InputDecoration(
                                hintText: 'Add a new todo here',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.purple[300],
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              isEdit
                                  ? _handleTodoUpdate()
                                  : _handleAddNewToDo();
                            },
                            icon: isEdit
                                ? const Icon(
                                    Icons.edit,
                                  )
                                : const Icon(
                                    Icons.plus_one,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
