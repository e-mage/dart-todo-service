A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/echo/<message>` (echo_server.dart) and `/todos` (todo_server.dart).

# Running the sample

## Running **echo_server** with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```bash
$ dart run bin/echo_server.dart
Server listening on port 8080
```

And then from a second terminal:

```bash
$ curl http://localhost:8080
Hello, World!

$ curl http://localhost:8080/echo/I_love_Dart
I_love_Dart
```

## Running **todo_server** with the Dart SDK

```bash
$ dart run bin/todo_server.dart
Server listening on port 8080
```

And then from a second terminal:

```bash
$ curl http://localhost:8080/todos
[{"id":1,"task":"Learn Dart","completed":true},{"id":2,"task":"Exam Dart","completed":false},{"id":3,"task":"To be expert in Dart","completed":false}]

$ curl -X POST http://localhost:8080/todos  -d '{"task": "Learn Flutter"}' -H "Content-Type: application/json"
Todo added

$ curl -X POST http://localhost:8080/todos -d '{"task": "Exam Flutter"}' -H "Content-Type: application/json"
Todo added

$ curl http://localhost:8080/todos
[{"id":1,"task":"Learn Dart","completed":true},{"id":2,"task":"Exam Dart","completed":false},{"id":3,"task":"To be expert in Dart","completed":false},{"id":4,"task":"Learn Flutter","completed":false},{"id":5,"task":"Exam Flutter","completed":false}]

$ curl -X PUT http://localhost:8080/todos/2 -d '{"task": "Exam Dart", "completed": true}' -H "Content-Type: application/json"
Todo updated

$ curl http://localhost:8080/todos
[{"id":1,"task":"Learn Dart","completed":true},{"id":2,"task":"Exam Dart","completed":true},{"id":3,"task":"To be expert in Dart","completed":false},{"id":4,"task":"Learn Flutter","completed":false},{"id":5,"task":"Exam Flutter","completed":false}]

$ curl -X DELETE http://localhost:8080/todos/1
Todo deleted

$ curl http://localhost:8080/todos
[{"id":2,"task":"Exam Dart","completed":true},{"id":3,"task":"To be expert in Dart","completed":false},{"id":4,"task":"Learn Flutter","completed":false},{"id":5,"task":"Exam Flutter","completed":false}]
```

## Running **echo_server** with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```bash
$ docker build . -t my_dart_echo_server

$ docker run -it -p 8080:8080 my_dart_echo_server
Server listening on port 8080
```

And then from a second terminal:

```bash
$ curl http://localhost:8080
Hello, World!

$ curl http://localhost:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:

```bash
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```

## Running tests

There are some tests for **echo_server**:

```bash
$ dart test test/server_test.dart

Resolving dependencies in `dart-todo-service`... 
Downloading packages... (2.6s)
Got dependencies in `dart-todo-service`.
Building package executable... (6.3s)
Built test:test.
00:05 +3: All tests passed!
```
