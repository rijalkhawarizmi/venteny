// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'status_bloc.dart';

class StatusState extends Equatable {
  const StatusState({this.id=null});
  final int? id;
  
  @override
  List<Object?> get props => [id];

  StatusState copyWith({
    int? id,
  }) {
    return StatusState(
      id: id ?? this.id,
    );
  }
}
