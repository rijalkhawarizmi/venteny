// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_task_bloc.dart';

enum StatusDelete {initial,loading,success,failure}

class DeleteTaskState extends Equatable {
  const DeleteTaskState({this.status=StatusDelete.initial});
  final StatusDelete status;
  
  @override
  List<Object> get props => [status];

  DeleteTaskState copyWith({
    StatusDelete? status,
  }) {
    return DeleteTaskState(
      status: status ?? this.status,
    );
  }
}
