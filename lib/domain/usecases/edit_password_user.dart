import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../repositories/user_repository.dart';

class EditPasswordUser{
  final UserRepository repository;
  EditPasswordUser(this.repository);

  Future<Either <Failure, String>> executeEditPassword(String newPassword, String oldPassword) {
    return repository.editPassword(newPassword, oldPassword);
  }
}