import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taba/utils/failure.dart';

import '../entities/user_data.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> registerUser(String name, String email, String password);
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<UserCredential> googleLogin();
  Future<Either<Failure, UserData>> userData();
}