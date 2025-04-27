class TaskModel {
  final String id;
  final String title;
  final String priority;
  final DateTime createdAt;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.priority,
    required this.createdAt,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as String,
        title: json['title'] as String,
        priority: json['priority'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        isCompleted: json['isCompleted'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'priority': priority,
        'createdAt': createdAt.toIso8601String(),
        'isCompleted': isCompleted,
  };
}
