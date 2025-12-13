import '../../../../core/resources/data_state.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repo;
  SignInUseCase(this._repo);
  Future<DataState<AppUser>> call(String email, String password) => _repo.signIn(email, password);
}

class SignUpUseCase {
  final AuthRepository _repo;
  SignUpUseCase(this._repo);
  Future<DataState<AppUser>> call(String email, String password) => _repo.signUp(email, password);
}

class SignOutUseCase {
  final AuthRepository _repo;
  SignOutUseCase(this._repo);
  Future<void> call() => _repo.signOut();
}

class GetAuthStreamUseCase {
  final AuthRepository _repo;
  GetAuthStreamUseCase(this._repo);
  Stream<AppUser?> call() => _repo.user;
}