import 'package:equatable/equatable.dart';
import 'package:taba/domain/entities/p3k_list_entity.dart';

class P3kListResponse extends Equatable {
  P3kListResponse({
    required this.title,
    required this.urlPhoto,
    required this.linkToDetail,
  });

  final String title;
  final String urlPhoto;
  final String linkToDetail;

  P3kListEntity toEntity() {
    return P3kListEntity(
      title: this.title,
      urlPhoto: this.urlPhoto,
      linkToDetail: this.linkToDetail,
    );
  }

  @override
  List<Object?> get props => [
        title,
        urlPhoto,
        linkToDetail,
      ];
}
