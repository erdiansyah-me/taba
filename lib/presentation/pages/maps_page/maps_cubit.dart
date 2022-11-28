import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/domain/entities/gempa_entity.dart';
import 'package:taba/domain/usecases/get_list_gempa.dart';

class MapsCubit extends Cubit<MapsState> {
  final GetListGempa _getListGempa;

  MapsCubit(this._getListGempa) : super(MapsInitial());
  String _message = '';
  String get message => _message;

  Future<void> getListGempa() async {
    emit(MapsLoading());
    final result = await _getListGempa.executeGetGempa();
    result.fold(
      (failure) => emit(MapsError(failure.message)),
      (success) => emit(MapsLoaded(success)),
    );
  }
}

abstract class MapsState extends Equatable {
  MapsState();

  @override
  List<Object?> get props => [];
}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsError extends MapsState {
  final String message;

  MapsError(this.message);

  @override
  List<Object?> get props => [message];
}

class MapsLoaded extends MapsState {
  final List<GempaEntity> result;
  MapsLoaded(this.result);

  @override
  List<Object?> get props => [result];
}
