part of 'date_bloc.dart';

class DateEvent extends Equatable {
  const DateEvent({required this.date});
  final DateTime date;
  

  @override
  List<Object> get props => [date];
}
