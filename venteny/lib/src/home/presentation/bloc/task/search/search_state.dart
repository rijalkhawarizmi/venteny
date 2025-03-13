// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum StatusSearch { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState(
      {this.status = StatusSearch.initial, this.taskEntity = const [],this.title=""});

  final StatusSearch status;
  final String title;
  final List<TaskEntity> taskEntity;

  @override
  List<Object> get props => [status, taskEntity];

  SearchState copyWith({
    StatusSearch? status,
    String? title,
    List<TaskEntity>? taskEntity,
  }) {
    return SearchState(
      status:  status ?? this.status,
      title:  title ?? this.title,
      taskEntity:  taskEntity ?? this.taskEntity,
    );
  }
}
