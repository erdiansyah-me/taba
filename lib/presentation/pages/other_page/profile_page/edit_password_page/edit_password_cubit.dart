import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/domain/usecases/edit_password_user.dart';

class EditPasswordCubit extends Cubit<EditPasswordState> {
  final EditPasswordUser _editPasswordUser;

  EditPasswordCubit(this._editPasswordUser) : super(EditPasswordInitial());
  final String _message = '';
  String get message => _message;

  Future<void> editPassword(String newPassword, String password) async {
    emit(EditPasswordLoading());
    final result =
        await _editPasswordUser.executeEditPassword(newPassword, password);

    result.fold(
      (failure) => emit(EditPasswordError(failure.message)),
      (success) {
        emit(EditPasswordSuccess(success));
      },
    );
  }
}

abstract class EditPasswordState extends Equatable {
  EditPasswordState();

  @override
  List<Object?> get props => [];
}

class EditPasswordInitial extends EditPasswordState {}

class EditPasswordLoading extends EditPasswordState {}

class EditPasswordSuccess extends EditPasswordState {
  final String message;
  EditPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EditPasswordError extends EditPasswordState {
  final String message;
  EditPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
