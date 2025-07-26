abstract class UserEvent {}

class LoginRequested extends UserEvent {
  final String email, password;
  LoginRequested({required this.email, required this.password});
}

class SignupRequested extends UserEvent {
  final String email, password;
  SignupRequested({required this.email, required this.password});
}
