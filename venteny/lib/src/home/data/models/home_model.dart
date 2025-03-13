import '../../domain/entities/home_entity.dart';




class ResultField {
  static final List<String> values = [id, title, description, date,status];
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String date = 'date';
  static const String status = 'status';
}

class TasksModel extends TaskEntity {
  final int id;
  final String title;
  final String description;
  final String dueDate;
  final int status;
  const TasksModel({required this.id, required this.title, required this.description, required this.dueDate, required this.status})
      : super(
            id:id,
            title: title,
            description: description,
            dueDate: dueDate,
            status: status);

    TasksModel copy({
    int? id,
    String? title,
    String? description,
    String? dueDate,
    int? status,

  }) =>
      TasksModel(id: id ?? this.id, title: title ?? this.title, description: description ?? this.description, dueDate: dueDate ?? this.dueDate, status: status ?? this.status);

  static TasksModel fromJson(Map<String, Object?> json) => TasksModel(
        id: json[ResultField.id] as int,
        title: json[ResultField.title] as String,
        description: json[ResultField.description] as String,
        dueDate: json[ResultField.date] as String,
        status: json[ResultField.status] as int,
        
      );
  Map<String, Object?> toJson() => {
        ResultField.id: id,
        ResultField.title: title,
        ResultField.description: description,
        ResultField.date: dueDate,
        ResultField.status: status,
        
      };
}
