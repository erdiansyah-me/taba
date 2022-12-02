import 'package:dartz/dartz.dart';
import 'package:taba/domain/repositories/data_repository.dart';
import 'package:taba/utils/failure.dart';

import '../entities/p3k_list_entity.dart';

class GetListP3k {
  final DataRepository repository;
  GetListP3k(this.repository);

  Future<Either<Failure, List<P3kListEntity>>> executeGetP3kList() {
    return repository.getP3kList();
  }
}