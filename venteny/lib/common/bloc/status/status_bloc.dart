import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(StatusState()) {
    on<StatusEvent>(_chooseStatus);
  }
 
  void _chooseStatus(StatusEvent event,Emitter<StatusState> emit){
    final Map<String, int> statusMap = {
    "PENDING": 1,
    "IN PROGRESS": 2,
    "COMPLETED": 3,
  };
    if(event.status==null){
     return emit(StatusState());
    }
    emit(state.copyWith(id: event.status));
  }
}
