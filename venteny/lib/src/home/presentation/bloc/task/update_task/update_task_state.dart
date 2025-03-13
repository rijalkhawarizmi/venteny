part of 'update_task_bloc.dart';

enum StatusUpdate {initial,loading,success,failure}

class UpdateTaskState extends Equatable {
  const UpdateTaskState({this.status=StatusUpdate.initial});
  final StatusUpdate status;
  
  @override
  List<Object> get props => [status];

  UpdateTaskState copyWith({
    StatusUpdate? status,
  }) {
    return UpdateTaskState(
      status: status ?? this.status,
    );
  }
}
