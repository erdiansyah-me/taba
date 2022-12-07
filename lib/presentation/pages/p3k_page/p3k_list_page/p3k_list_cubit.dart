import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/p3k_list_entity.dart';
import '../../../../domain/usecases/get_list_p3k.dart';


class P3kListCubit extends Cubit<P3kListState> {
  final GetListP3k _getListP3k;

  P3kListCubit(this._getListP3k) : super(P3kListInitial());
  final String _message = '';
  String get message => _message;

  Future<void> getListP3k() async {
    emit(P3kListLoading());
    final result = await _getListP3k.executeGetP3kList();
    result.fold(
      (failure) => emit(P3kListError(failure.message)),
      (success) => emit(P3kListLoaded(success)),
    );
  }
}

abstract class P3kListState extends Equatable {
  P3kListState();

  @override
  List<Object?> get props => [];
}

class P3kListInitial extends P3kListState {}

class P3kListLoading extends P3kListState {}

class P3kListError extends P3kListState {
  final String message;

  P3kListError(this.message);

  @override
  List<Object?> get props => [message];
}

class P3kListLoaded extends P3kListState {
  final List<P3kListEntity> result;
  P3kListLoaded(this.result);

  @override
  List<Object?> get props => [result];
}