import 'package:flutter/material.dart';
import 'package:wire/wire.dart';
import 'package:wire_example_shared/todo/const/application_state.dart';
import 'package:wire_example_shared/todo/const/data_keys.dart';
import 'package:wire_example_shared/todo/controller/todo_controller.dart';
import 'package:wire_example_shared/todo/model/todo_model.dart';
import 'package:wire_example_shared/todo/service/web_database_service.dart';
import 'package:wire_flutter_todo/flutter/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Wire.data(DataKeys.STATE, value: TodoApplicationState.LOADING);

  final databaseService = WebDatabaseService();
  final todoModel = TodoModel(databaseService);

  if (await todoModel.whenReady) {
    print('> Main -> main: todoModel.whenReady');
    TodoController(todoModel);
    runApp(TodoAppFlutter());
  }

  Wire.data(DataKeys.STATE, value: TodoApplicationState.READY);
}
