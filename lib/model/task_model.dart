import 'package:todo_simple_app/core/utiles.dart';

class TaskModel {
  static const String collectionName = "Tasks Collection";

  String title;
  String description;
  String? id;
  DateTime selectedDate;
  bool isDone;

  TaskModel({
    required this.title,
    this.id,
    required this.description,
    required this.selectedDate,
    this.isDone = false,
  });

  factory TaskModel.fromFirestore(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]),
      isDone: json["isDone"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "selectedDate": extractDate(selectedDate).millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }

  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? selectedDate,
    bool? isDone,
    String? id, // Add the id parameter here
  }) {
    return TaskModel(
      id: id ?? this.id,
      // Include the id in the copy
      title: title ?? this.title,
      description: description ?? this.description,
      selectedDate: selectedDate ?? this.selectedDate,
      isDone: isDone ?? this.isDone,
    );
  }

}
