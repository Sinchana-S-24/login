abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String userId;
  final String password;

  LoginSubmitted(this.userId, this.password);
}
