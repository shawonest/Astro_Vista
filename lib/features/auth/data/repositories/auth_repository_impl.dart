import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart'; // Using DioException to keep DataState consistent
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Stream<AppUser?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return AppUser(uid: firebaseUser.uid, email: firebaseUser.email);
    });
  }

  @override
  Future<DataState<AppUser>> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      final user = credential.user!;
      return DataSuccess(AppUser(uid: user.uid, email: user.email));
    } on FirebaseAuthException catch (e) {
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: ''),
        error: e.message,
        type: DioExceptionType.unknown,
      ));
    }
  }

  @override
  Future<DataState<AppUser>> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      final user = credential.user!;
      return DataSuccess(AppUser(uid: user.uid, email: user.email));
    } on FirebaseAuthException catch (e) {
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: ''),
        error: e.message,
        type: DioExceptionType.unknown,
      ));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}