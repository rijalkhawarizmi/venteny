part of 'status_bloc.dart';

class StatusEvent extends Equatable {
  const StatusEvent({required this.status});
  final int? status;

  @override
  List<Object?> get props => [status];
}
