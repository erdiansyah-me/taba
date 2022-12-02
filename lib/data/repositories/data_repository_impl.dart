import 'package:taba/data/datasources/remote_data_sources.dart';
import 'package:taba/domain/entities/gempa_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:taba/domain/entities/p3k_list_entity.dart';
import 'package:taba/domain/repositories/data_repository.dart';
import 'package:taba/utils/failure.dart';

class DataRepositoryImpl implements DataRepository {

  final RemoteDataSource remoteDataSource;

  DataRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<GempaEntity>>> getListGempaInfoTerkini() async {
    try {
      final result = await remoteDataSource.getListGempaInfoTerkini();
      return Right(result.map((model) => model.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<P3kListEntity>>> getP3kList() async {
    try {
      final result = await remoteDataSource.getP3kListResponse();
      return Right(result.map((e) => e.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
}