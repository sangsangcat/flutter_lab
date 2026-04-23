import 'package:flutter/material.dart';
import '../providers/todos_provider.dart';
import 'package:provider/provider.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    //add.....................
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (bool? checked) {
          //상태 변경..
          //상태를 read 해서 화면 출력하겠다면.. Provider.of, Consumer, Selector
          //변경... Provider.of
          //listen: false, 상태값 변경 시도다.. 변경되었을 때 나를 rebuild 해야하는가? falsse 하지마라..
          Provider.of<TodosModel>(context, listen: false).toggleTodo(todo);
        },
      ),
      title: Text(todo.title),
      trailing: IconButton(
        onPressed: () {
          Provider.of<TodosModel>(context, listen: false).deleteTodo(todo);
        },
        icon: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
