// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_task_bloc.dart';

enum StatusCreate {initial,loading,success,failure}

class CreateTaskState extends Equatable {
  const CreateTaskState({this.isCreated=false,this.status=StatusCreate.initial});
  final bool isCreated;
  final StatusCreate status;
  
  @override
  List<Object> get props => [isCreated,status];

  CreateTaskState copyWith({
    bool? isCreated,
    StatusCreate? status,
  }) {
    return CreateTaskState(
      isCreated: isCreated ?? this.isCreated,
      status: status ?? this.status,
    );
  }
}

