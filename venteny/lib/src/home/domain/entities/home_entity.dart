// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
 final int id;
 final String title;
 final String description;
 final String dueDate;
 final  int status;
 const  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  // TODO: implement props
  List<Object> get props => [id,title, description, dueDate, status];
  // TODO: Define TaskEntity properties
}
