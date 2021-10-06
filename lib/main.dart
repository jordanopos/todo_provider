import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'models/todo.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoState>(
      create: (context) => TodoState(),
      child: MaterialApp(
        title: "Todo App",
        home: TodoHome(),
      ),
    );
  }
}

class TodoHome extends StatefulWidget {
  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("i have rebuilt");
    var todos = Provider.of<TodoState>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DialogContainer(_nameController, _titleController);
              })),
          child: Center(child: Icon(Icons.add))),
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => todos.deleteAllItems(),
            icon: Icon(Icons.delete_forever))
      ], title: Text("Todo App")),
      body: ListView.builder(
        itemCount: todos.todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("You have deleted the item at $index")));
                  todos.deleteItem(index);
                },
              ),
              subtitle: Text(todos.todoItems[index].name),
              title: Text(todos.todoItems[index].title));
        },
      ),
    );
  }
}

class DialogContainer extends StatelessWidget {
  final TextEditingController _titleController;
  final TextEditingController _nameController;

  DialogContainer(this._nameController, this._titleController);

  @override
  Widget build(BuildContext context) {
    var todos = Provider.of<TodoState>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Add items here")),
      body: Center(
          child: Column(children: [
        TextField(controller: _titleController),
        TextField(controller: _nameController),
        MaterialButton(
            color: Colors.blue,
            onPressed: () {
              //! adding the items to the list
              todos.addItems(
                  TodoModel(_nameController.text, _titleController.text));
              //! going back so that the user doesnt have to
              Navigator.pop(context);

              //! clearing the editing controllers
              _nameController.clear();
              _titleController.clear();
            },
            child: Center(child: Text("Add todo")))
      ])),
    );
  }
}
