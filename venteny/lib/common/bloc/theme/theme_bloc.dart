import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<ThemeEvent>(_changeTheme);
  }

  void _changeTheme(ThemeEvent event,Emitter<ThemeState> emit){
      if(state.isModeDark==false){
        emit(state.copyWith(isModeDark: true));
      }else{
        emit(state.copyWith(isModeDark: false));
      }
  }
}
