import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/domain/entities/user_data.dart';
import 'package:taba/domain/usecases/get_user_data.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final GetUserData _getUserData;

  UserDataCubit(this._getUserData) : super(UserDataInitial());
  final String _message = '';
  String get message => _message;

  Future<void> getUserData() async {
    emit(UserDataLoading());

    final result = await _getUserData.executeUserData();

    result.fold(
      (failure) => emit(UserDataError(failure.message)),
      (success) {
        emit(UserDataSuccess(success));
      },
    );
  }
}

abstract class UserDataState extends Equatable {
  UserDataState();

  @override
  List<Object?> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final UserData result;
  UserDataSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class UserDataError extends UserDataState {
  final String message;
  UserDataError(this.message);

  @override
  List<Object?> get props => [message];
}
