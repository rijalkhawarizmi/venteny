part of 'create_task_bloc.dart';

class CreateTaskEvent extends Equatable {
  const CreateTaskEvent({required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  List<Object> get props => [taskEntity];
}
