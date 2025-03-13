// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_tasks_bloc.dart';

enum StatusGetTasks {initial,loading,success,failure}

class GetTasksState extends Equatable {
  const GetTasksState({this.taskEntity=const [],this.status=StatusGetTasks.initial});
  final List<TaskEntity> taskEntity;  
  final StatusGetTasks status;
  @override
  List<Object> get props => [taskEntity,status];

  GetTasksState copyWith({
    List<TaskEntity>? taskEntity,
    StatusGetTasks? status,
  }) {
    return GetTasksState(
      taskEntity: taskEntity ?? this.taskEntity,
      status: status ?? this.status,
    );
  }
}
