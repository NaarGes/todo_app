import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  final bool isDone;
  final bool isDeleted;
  final bool isFavorite;

  Task({
    required this.title,
    this.description = '',
    required this.date,
    this.isDone = false,
    this.isDeleted = false,
    this.isFavorite = false,
  }) : id = const Uuid().v4();

  Task copyWith({
    String? title,
    String? description,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  @override
  List<Object?> get props => [id];
}
