import 'package:dartz/dartz.dart';
import 'package:taba/domain/entities/gempa_entity.dart';

import '../../utils/failure.dart';

abstract class DataRepository {
  Future<Either<Failure, List<GempaEntity>>> getListGempaInfoTerkini();
}