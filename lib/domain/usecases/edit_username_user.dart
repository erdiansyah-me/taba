import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../repositories/user_repository.dart';

class EditUsernameUser{
  final UserRepository repository;
  EditUsernameUser(this.repository);

  Future<Either <Failure, String>> executeEditUsername(String newUsername, String password) {
    return repository.editUsername(newUsername, password);
  }
}