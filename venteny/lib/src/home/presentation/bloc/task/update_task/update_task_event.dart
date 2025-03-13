part of 'update_task_bloc.dart';

class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent({required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  List<Object> get props => [taskEntity];
}
