part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent({this.title,this.status});
  final String? title;
  final int? status;

  @override
  List<Object?> get props => [title,status];
}
