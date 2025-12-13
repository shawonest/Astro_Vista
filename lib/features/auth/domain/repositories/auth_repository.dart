import '../../../../core/resources/data_state.dart';
import '../entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> get user; // Stream to listen to auth state changes
  Future<DataState<AppUser>> signIn(String email, String password);
  Future<DataState<AppUser>> signUp(String email, String password);
  Future<void> signOut();
}