import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TasksState> emit) {
    print('TasksBloc: AddTask event is handled');
    emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
    // final state = this.state;
    // emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  FutureOr<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    print('TasksBloc: UpdateTask event is handled');
    int index = state.allTasks.indexOf(event.task);

    emit(
      TasksState(
        allTasks: List.from(state.allTasks)
          ..removeAt(index)
          ..insert(index, event.task.copyWith(isDone: !event.task.isDone)),
      ),
    );
  }

  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    print('TasksBloc: DeleteTask event is handled');
    emit(TasksState(allTasks: List.from(state.allTasks)..remove(event.task)));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
