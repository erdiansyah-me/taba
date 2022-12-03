import 'package:equatable/equatable.dart';

class IsSuccessArgs extends Equatable {
  IsSuccessArgs({
    required this.isSuccess,
    required this.konteks,
    required this.navigateTo,
    this.message,
  });

  final bool isSuccess;
  final String konteks;
  final String navigateTo;
  String? message;

  @override
  List<Object?> get props => [
        isSuccess,
        konteks,
        navigateTo,
        message,
      ];
}
