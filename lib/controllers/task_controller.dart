import 'package:prioritize/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class TaskController with ChangeNotifier {
  final _client = Supabase.instance.client;
  final Uuid _uuid = const Uuid();
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  Future<List<TaskModel>> getTasks() async {
    final response = await _client.from('TASKS').select();

    // Mapeia o retorno da consulta para a lista de TaskModels
    _tasks = (response as List).map((json) => TaskModel.fromJson(json)).toList();

    // Notifica a UI que houve alterações na lista de tarefas
    notifyListeners();
    return _tasks;
  }

  List<TaskModel> getTasksByDate(DateTime? date) {
  if (date == null) return tasks;

  return tasks.where((task) {
    return isSameDay(task.createdAt, date);
  }).toList();
}


  Future<void> addTask(String title, String priority) async {
    final task = TaskModel(
      id: _uuid.v4(),
      title: title,
      priority: priority,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    // Insere a nova tarefa no banco de dados
    await _client.from('TASKS').insert(task.toJson());

    // Atualiza a lista local e notifica a UI
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    // Atualiza a tarefa no banco de dados
    await _client.from('TASKS').update(task.toJson()).eq('id', task.id);

    // Atualiza a tarefa localmente e notifica a UI
    final index = _tasks.indexWhere((t) => t.id == task.id);
    _tasks[index] = task;
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    // Deleta a tarefa do banco de dados
    await _client.from('TASKS').delete().eq('id', id);

    // Remove a tarefa localmente e notifica a UI
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
