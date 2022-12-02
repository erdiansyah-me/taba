import 'package:equatable/equatable.dart';

class P3kListEntity extends Equatable {
  P3kListEntity({
    required this.title,
    required this.urlPhoto,
    required this.linkToDetail,
  });

  final String title;
  final String urlPhoto;
  final String linkToDetail;

  @override
  List<Object?> get props => [
    title,
    urlPhoto,
    linkToDetail,
  ];
}