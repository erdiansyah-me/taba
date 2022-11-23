import 'package:dartz/dartz.dart';
import 'package:taba/domain/entities/user_data.dart';
import 'package:taba/utils/failure.dart';

import '../repositories/user_repository.dart';

class GetUserData{
  final UserRepository repository;
  GetUserData(this.repository);

  Future<Either <Failure, UserData>> executeUserData() {
    return repository.userData();
  }
}