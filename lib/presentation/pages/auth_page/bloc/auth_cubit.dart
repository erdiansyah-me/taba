import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/domain/usecases/auth_user.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUser _authUser;

  AuthCubit(this._authUser) : super(AuthInitial());
  String _message = '';
  String get message => _message;

  Future<void> registerUser(String name, String email, String password) async {
    emit(AuthLoading());
    final result = await _authUser.executeRegister(name, email, password);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) {
        _message = success;
        emit(AuthSuccess());
      },
    );
  }

  Future<void> loginUser(String email, String password) async {
    emit(AuthLoading());
    final result = await _authUser.executeLogin(email, password);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) {
        _message = success;
        emit(AuthSuccess());
      },
    );
  }
}

abstract class AuthState extends Equatable {
  AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
