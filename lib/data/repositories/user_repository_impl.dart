import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taba/domain/entities/user_data.dart';
import 'package:taba/domain/repositories/user_repository.dart';
import 'package:taba/utils/failure.dart';

class UserRepositoryImpl extends UserRepository {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, String>> registerUser(
      String name, String email, String password) async {
    try {
      var registUser = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await registUser.user!.updateDisplayName(name);
      return const Right('Daftar Berhasil');
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Right('Login Berhasil');
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserData>> userData() async {
    try {
      final user = firebaseAuth.currentUser;

      return Right(
        UserData(
          uid: user!.uid,
          displayName: user.displayName!,
          email: user.email!,
          photoURL: user.photoURL,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> editEmail(String newEmail, String password) async {
    try {
      final user = firebaseAuth.currentUser;


      final credential = EmailAuthProvider.credential(email: user!.email!, password: password);
      await user.reauthenticateWithCredential(credential);
      await user.updateEmail(newEmail);

      return const Right('Edit Email, silahkan cek kotak masuk Email anda');
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> editUsername(String newUsername, String password) async {
    try {
      final user = firebaseAuth.currentUser;


      final credential = EmailAuthProvider.credential(email: user!.email!, password: password);
      await user.reauthenticateWithCredential(credential);
      await user.updateDisplayName(newUsername);

      return const Right('Edit Username');
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message!));
    }
  }
  
  @override
  Future<Either<Failure, String>> editPassword(String newPassword, String oldPassword) async {
    try {
      final user = firebaseAuth.currentUser;

      final credential = EmailAuthProvider.credential(email: user!.email!, password: oldPassword);

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return const Right('Edit Password Berhasil');
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message!));
    }
  }
  
  @override
  Future<bool> logout() async {
    await firebaseAuth.signOut();
    return true;
  }
}
