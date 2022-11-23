import 'package:dartz/dartz.dart';
import 'package:taba/domain/repositories/user_repository.dart';
import 'package:taba/utils/failure.dart';

class AuthUser {
  final UserRepository repository;
  AuthUser(this.repository);

  Future<Either<Failure, String>> executeRegister(String name, String email, String password) {
    return repository.registerUser(name, email, password);
  }
  Future<Either<Failure, String>> executeLogin(String email, String password) {
    return repository.loginUser(email, password);
  }
}