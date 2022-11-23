import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<UserCredential> googleLogin() async {
    try {
      final googleAccount = await GoogleSignIn().signIn();
      final googleAuth = await googleAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Either<Failure, UserData>> userData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

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
}
