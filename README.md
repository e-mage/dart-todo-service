A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/echo_server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://localhost:8080
Hello, World!
$ curl http://localhost:8080/echo/I_love_Dart
I_love_Dart
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://localhost:8080
Hello, World!
$ curl http://localhost:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```

# dart-todo-service
```
$ dart run bin/todo_server.dart
Serving at http://localhost:8080
```

And then from a second terminal:
```
$ curl http://localhost:8080/todos
[]
$ curl -X POST http://localhost:8080/todos  -d '{"task": "Learn Dart"}' -H "Content-Type: application/json"
Todo added
$ curl -X POST http://localhost:8080/todos -d '{"task": "Take exam"}' -H "Content-Type: application/json"
Todo added
$ curl http://localhost:8080/todos
[{"id":1,"task":"Learn Dart","completed":false},{"id":2,"task":"Take exam","completed":false}]
$ curl -X PUT http://localhost:8080/todos/1 -d '{"task": "Learn Dart", "completed": true}' -H "Content-Type: application/json"
Todo updated
$ curl http://localhost:8080/todos
[{"id":1,"task":"Learn Dart","completed":true},{"id":2,"task":"Take exam","completed":false}]
$ curl -X DELETE http://localhost:8080/todos/1
Todo deleted
$ curl http://localhost:8080/todos
[{"id":2,"task":"Take exam","completed":false}]
```
