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
    on<MarkFavoriteOrUnFavoriteTask>(_onMarkFavoriteOrUnFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreEvent>(_onRestoreEvent);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: AddTask event is handled');
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
    // final state = this.state;
    // emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  FutureOr<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: UpdateTask event is handled');
    final state = this.state;
    final task = event.task;
    List<Task> pendings = state.pendingTasks;
    List<Task> completeds = state.completedTasks;
    List<Task> favorites = state.favoriteTasks;

    if (task.isDone == false) {
      pendings = List.from(pendings)..remove(task);
      completeds = List.from(completeds)..insert(0, task.copyWith(isDone: true));
      if (task.isFavorite) {
        var taskIndex = favorites.indexOf(task);
        favorites = List.from(favorites)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      completeds = List.from(completeds)..remove(task);
      pendings = List.from(pendings)..insert(0, task.copyWith(isDone: false));
      if (task.isFavorite) {
        var taskIndex = favorites.indexOf(task);
        favorites = List.from(favorites)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }

    emit(
      TasksState(
        pendingTasks: pendings,
        completedTasks: completeds,
        favoriteTasks: favorites,
        removedTasks: state.removedTasks,
      ),
    );
  }

  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: DeleteTask event is handled');
    emit(TasksState(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
    ));
  }

  FutureOr<void> _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    debugPrint('TasksBloc: DeleteTask event is handled');
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  void _onMarkFavoriteOrUnFavoriteTask(
      MarkFavoriteOrUnFavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (event.task.isDone == false) {
      var taskIndex = pendingTasks.indexOf(event.task);
      if (event.task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      var taskIndex = completedTasks.indexOf(event.task);
      if (event.task.isFavorite == false) {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreEvent(RestoreEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
            0,
            event.task.copyWith(
              isDeleted: false,
              isDone: false,
              isFavorite: false,
            ),
          ),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
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
