import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/use_case/auth_usecases.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email, password;
  const AuthSignIn(this.email, this.password);
}

class AuthSignUp extends AuthEvent {
  final String email, password;
  const AuthSignUp(this.email, this.password);
}

class AuthSignOut extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final AppUser user;
  const AuthAuthenticated(this.user);
}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthBloc(
      this._signInUseCase,
      this._signUpUseCase,
      this._signOutUseCase,
      ) : super(AuthInitial()) {
    on<AuthSignIn>(_onSignIn);
    on<AuthSignUp>(_onSignUp);
    on<AuthSignOut>(_onSignOut);
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signInUseCase(event.email, event.password);
    if (result is DataSuccess) {
      emit(AuthAuthenticated(result.data!));
    } else {
      emit(AuthError(result.error?.error.toString() ?? "Sign In Failed"));
    }
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signUpUseCase(event.email, event.password);
    if (result is DataSuccess) {
      emit(AuthAuthenticated(result.data!));
    } else {
      emit(AuthError(result.error?.error.toString() ?? "Sign Up Failed"));
    }
  }

  void _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    await _signOutUseCase();
    emit(AuthInitial());
  }
}