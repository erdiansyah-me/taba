import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/domain/usecases/register_user.dart';

class AuthCubit extends Cubit<AuthState> {
  static const registerSuccessMessage = 'Daftar Berhasil';

  final RegisterUser _registerUser;

  AuthCubit(this._registerUser) : super(AuthInitial());
  String _message = '';
  String get message => _message;

  Future<void> registerUser(String name, String email, String password) async {
    emit(AuthLoading());
    final result = await _registerUser.execute(name, email, password);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) {
        _message = success;
        emit(AuthSuccess());
      },
    );
  }
}

class AuthState extends Equatable {
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
