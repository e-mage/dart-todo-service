import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class Todo {
  int id;
  String task;
  bool completed;

  Todo({
    required this.id,
    required this.task,
    this.completed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'completed': completed,
    };
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      task: json['task'],
      completed: json['completed'] ?? false,
    );
  }
}

class TodoService {
  final List<Todo> _todos = [
    Todo(id: 1, task: 'Learn Dart', completed: true),
    Todo(id: 2, task: 'Exam Dart', completed: false),
    Todo(id: 3, task: 'To be expert in Dart', completed: false),
  ];
  int _nextId = 4;

  List<Todo> get todos => _todos;

  Todo? getTodoById(int id) {
    return _todos.firstWhere((todo) => todo.id == id);
  }

  void addTodo(String task) {
    _todos.add(Todo(id: _nextId++, task: task));
  }

  void updateTodo(int id, String task, bool completed) {
    final todo = getTodoById(id);
    if (todo != null) {
      todo.task = task;
      todo.completed = completed;
    }
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
  }
}

void main() async {
  final service = TodoService();

  final router = Router()
    ..get('/todos', (Request request) {
      final jsonTodos = service.todos.map((todo) => todo.toJson()).toList();
      return Response.ok(json.encode(jsonTodos), headers: {'Content-Type': 'application/json'});
    })
    ..post('/todos', (Request request) async {
      final payload = await request.readAsString();
      final data = json.decode(payload);
      service.addTodo(data['task']);
      //return Response.ok('Todo added');
      final jsonTodos = service.todos.map((todo) => todo.toJson()).toList();
      return Response.ok(json.encode(jsonTodos), headers: {'Content-Type': 'application/json'});
    })
    ..put('/todos/<id>', (Request request, String id) async {
      final payload = await request.readAsString();
      final data = json.decode(payload);
      service.updateTodo(int.parse(id), data['task'], data['completed']);
      //return Response.ok('Todo updated');
      final jsonTodos = service.todos.map((todo) => todo.toJson()).toList();
      return Response.ok(json.encode(jsonTodos), headers: {'Content-Type': 'application/json'});
    })
    ..delete('/todos/<id>', (Request request, String id) {
      service.deleteTodo(int.parse(id));
      //return Response.ok('Todo deleted');
      final jsonTodos = service.todos.map((todo) => todo.toJson()).toList();
      return Response.ok(json.encode(jsonTodos), headers: {'Content-Type': 'application/json'});
    });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}
