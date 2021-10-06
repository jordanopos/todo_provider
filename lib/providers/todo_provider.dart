import 'package:flutter/cupertino.dart';
import 'package:todo/models/todo.dart';

class TodoState with ChangeNotifier {
  //! change notifieer helps us to change the state

  List<TodoModel> todoItems = [];

  //TODO poulate the table to show how the list works

  void addItems(TodoModel todo) {
    todoItems.add(todo);
    notifyListeners();
  }

  void deleteItem(int index) {
    todoItems.removeAt(index);

    notifyListeners();
  }

  void deleteAllItems() {
    todoItems = [];

    notifyListeners();
  }
}
