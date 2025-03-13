import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:venteny/src/authentication/domain/usecases/authentication_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginUsecase usecase})
      : _loginUsecase = usecase,
        super(LoginState()) {
    on<LoginEvent>(_login);
  }

  final LoginUsecase _loginUsecase;
  
  void _login(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: StatusLogin.loading));
    final result = await _loginUsecase(
        LoginParams(email: event.email, password: event.password));
    result.fold(
        (failure) => emit(state.copyWith(status: StatusLogin.failure)),
        (success) => emit(
            state.copyWith(status: StatusLogin.success, token: success.token)));
  }
}
