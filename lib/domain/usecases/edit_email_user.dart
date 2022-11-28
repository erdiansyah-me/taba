import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../repositories/user_repository.dart';

class EditEmailUser{
  final UserRepository repository;
  EditEmailUser(this.repository);

  Future<Either <Failure, String>> executeEditEmail(String newEmail, String password) {
    return repository.editEmail(newEmail, password);
  }
}