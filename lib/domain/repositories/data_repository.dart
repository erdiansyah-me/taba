import 'package:dartz/dartz.dart';
import 'package:taba/domain/entities/gempa_entity.dart';
import 'package:taba/domain/entities/p3k_list_entity.dart';

import '../../utils/failure.dart';

abstract class DataRepository {
  Future<Either<Failure, List<GempaEntity>>> getListGempaInfoTerkini();
  Future<Either<Failure, List<P3kListEntity>>> getP3kList();
}