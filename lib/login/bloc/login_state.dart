abstract class UserState {}

class AuthInitial extends UserState {}

class AuthLoading extends UserState {}

class Authenticated extends UserState {}

class Unauthenticated extends UserState {}

class AuthError extends UserState {
  final String message;
  AuthError(this.message);
}
