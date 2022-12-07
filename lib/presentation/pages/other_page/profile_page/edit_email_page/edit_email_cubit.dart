import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/domain/usecases/edit_email_user.dart';

class EditEmailCubit extends Cubit<EditEmailState> {
  final EditEmailUser _editEmailUser;

  EditEmailCubit(this._editEmailUser) : super(EditEmailInitial());
  final String _message = '';
  String get message => _message;

  Future<void> editEmail(String newEmail, String password) async {
    emit(EditEmailLoading());
    final result = await _editEmailUser.executeEditEmail(newEmail, password);

    result.fold(
      (failure) => emit(EditEmailError(failure.message)),
      (success) {
        emit(EditEmailSuccess(success));
      },
    );
  }
}

abstract class EditEmailState extends Equatable {
  EditEmailState();

  @override
  List<Object?> get props => [];
}

class EditEmailInitial extends EditEmailState {}

class EditEmailLoading extends EditEmailState {}

class EditEmailSuccess extends EditEmailState {
  final String message;
  EditEmailSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EditEmailError extends EditEmailState {
  final String message;
  EditEmailError(this.message);

  @override
  List<Object?> get props => [message];
}
