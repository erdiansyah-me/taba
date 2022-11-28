import 'package:dartz/dartz.dart';
import 'package:taba/domain/entities/gempa_entity.dart';
import 'package:taba/domain/repositories/data_repository.dart';
import 'package:taba/utils/failure.dart';

class GetListGempa {
  final DataRepository repository;
  GetListGempa(this.repository);

  Future<Either<Failure, List<GempaEntity>>> executeGetGempa() {
    return repository.getListGempaInfoTerkini();
  }
}