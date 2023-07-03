import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class TodosList extends StatefulWidget {
  const TodosList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TodosListState createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  final List<String> _todos = [];


  void _addTodo() async {
    final TextEditingController textEditingController = TextEditingController();

    final todo = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return _buildAddTodoDialog(textEditingController);
      },
    );
    if (todo != null && todo.isNotEmpty) {
      setState(() {
        _todos.add(todo);
      });
    }
  }

  AlertDialog _buildAddTodoDialog(TextEditingController textEditingController) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.multiline,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter your task'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newTodo = textEditingController.text;
            if (newTodo.isNotEmpty) {
              Navigator.of(context).pop(newTodo);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleTodoCompleted(int index) {
    final todo = _todos[index];
    final isCompleted = todo.startsWith('✓ ');
    setState(() {
      _todos[index] = isCompleted ? todo.substring(2) : '✓ $todo';
    });
  }
  void _counter(){
    int counter = 0;
    counter++;
  }

  Widget _buildTodoItem(int index) {
    final todo = _todos[index];
    return Dismissible(
      key: Key('$todo$index'),
      onDismissed: (direction) {
        _removeTodo(index);
      },
      background: Container(

        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: CheckboxListTile(
          title: Text(
            todo.startsWith('✓ ') ? todo.substring(2) : todo,
            style: TextStyle(
              decoration: todo.startsWith('✓ ') ? TextDecoration.lineThrough : null,
            ),
          ),
          value: todo.startsWith('✓ '),
          onChanged: (bool? value) {
            _toggleTodoCompleted(index);
          },
          secondary: IconButton(
            icon: const Icon(Icons.delete),
            onPressed:() {
              _removeTodo(index);
            },
        ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTodoItem(index);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),

    );
  }
}