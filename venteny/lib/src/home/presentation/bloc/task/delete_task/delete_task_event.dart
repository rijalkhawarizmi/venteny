part of 'delete_task_bloc.dart';

class DeleteTaskEvent extends Equatable {
  const DeleteTaskEvent({required this.id});
  final int id;
  @override
  List<Object> get props => [id];
}
