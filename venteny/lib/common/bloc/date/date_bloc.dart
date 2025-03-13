import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateState()) {
    on<DateEvent>(_chooseDate);
  }

  void _chooseDate(DateEvent event,Emitter<DateState> emit){
    emit(state.copyWith(date: event.date));
  }
}
