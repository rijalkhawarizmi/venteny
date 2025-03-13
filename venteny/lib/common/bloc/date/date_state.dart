// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'date_bloc.dart';

class DateState extends Equatable {
  const DateState({this.date});
  final DateTime? date;
  
  @override
  List<Object?> get props => [date];

  DateState copyWith({
    DateTime? date,
  }) {
    return DateState(
      date: date ?? this.date,
    );
  }
}

