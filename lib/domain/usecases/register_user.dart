import 'package:dartz/dartz.dart';
import 'package:taba/domain/repositories/user_repository.dart';
import 'package:taba/utils/failure.dart';

class RegisterUser {
  final UserRepository repository;
  RegisterUser(this.repository);

  Future<Either<Failure, String>> execute(String name, String email, String password) {
    return repository.registerUser(name, email, password);
  }
}