import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_cubit.dart';

import '../../../../domain/entities/p3k_list_entity.dart';
import '../../../../domain/usecases/get_list_p3k.dart';

class P3kSearchBloc extends Bloc<P3kSearchEvent, P3kSearchState> {
  final GetListP3k _getSearchP3k;

  P3kSearchBloc(this._getSearchP3k) : super(P3kSearchInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(P3kSearchLoading());

      final result = await _getSearchP3k.executeGetP3kList();
      result.fold(
        (failure) => emit(P3kSearchError(failure.message)),
        (success) {
          var search = success.where((element) {
            return element.title.toLowerCase().contains(query.toLowerCase());
          }).toList();
          emit(P3kSearchLoaded(search));
        },
      );
    }, transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).flatMap(mapper));
  }
  String _message = '';
  String get message => _message;
}

abstract class P3kSearchState extends Equatable {
  P3kSearchState();

  @override
  List<Object?> get props => [];
}

class P3kSearchInitial extends P3kSearchState {}

class P3kSearchLoading extends P3kSearchState {}

class P3kSearchError extends P3kSearchState {
  final String message;

  P3kSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class P3kSearchLoaded extends P3kSearchState {
  final List<P3kListEntity> result;
  P3kSearchLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

abstract class P3kSearchEvent extends Equatable {
  const P3kSearchEvent();

  @override
  List<Object?> get props => [];
}

class OnQueryChanged extends P3kSearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
