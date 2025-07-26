import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.completed
  });

  late final String id;
  late final String title;
  late final String description;
  late final DateTime dueDate;
  late final String priority;

  late final bool completed;
  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    completed=json['completed']??false;
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    dueDate = (json['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now();
    priority = json['priority'] ?? "Low";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'completed':completed,
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel.fromJson(map);
  }
}
