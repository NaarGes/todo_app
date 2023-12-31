import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String id;
  final String title;
  final bool isDone;
  final bool isDeleted;

  Task({
    required this.title,
    this.isDone = false,
    this.isDeleted = false,
  }) : id = const Uuid().v4();

  Task copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [id];
}
