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
    on<RemoveTask>(_onRemoveTask);
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: AddTask event is handled');
    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
      removedTasks: state.removedTasks,
    ));
    // final state = this.state;
    // emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  FutureOr<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: UpdateTask event is handled');
    int index = state.allTasks.indexOf(event.task);

    emit(
      TasksState(
        allTasks: List.from(state.allTasks)
          ..removeAt(index)
          ..insert(
            index,
            event.task.copyWith(isDone: !event.task.isDone),
          ),
        removedTasks: state.removedTasks,
      ),
    );
  }

  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: DeleteTask event is handled');
    emit(TasksState(allTasks: state.allTasks,
    removedTasks: List.from(state.removedTasks)..remove(event.task),));
  }

  FutureOr<void> _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: DeleteTask event is handled');
    emit(TasksState(
      allTasks: List.from(state.allTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)..add(event.task.copyWith(isDeleted: true)),
    ));
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
