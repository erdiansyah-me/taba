import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/usecases/edit_username_user.dart';

class EditUsernameCubit extends Cubit<EditUsernameState> {
  final EditUsernameUser _editDisplayName;

  EditUsernameCubit(this._editDisplayName) : super(EditUsernameInitial());
  String _message = '';
  String get message => _message;

  Future<void> editUsername(String newUsername, String password) async {
    emit(EditUsernameLoading());
    final result = await _editDisplayName.executeEditUsername(newUsername, password);

    result.fold(
          (failure) => emit(EditUsernameError(failure.message)),
          (success) {
        emit(EditUsernameSuccess(success));
      },
    );
  }
}

abstract class EditUsernameState extends Equatable {
  EditUsernameState();

  @override
  List<Object?> get props => [];
}

class EditUsernameInitial extends EditUsernameState {}

class EditUsernameLoading extends EditUsernameState {}

class EditUsernameSuccess extends EditUsernameState {
  final String message;
  EditUsernameSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EditUsernameError extends EditUsernameState {
  final String message;
  EditUsernameError(this.message);

  @override
  List<Object?> get props => [message];
}
