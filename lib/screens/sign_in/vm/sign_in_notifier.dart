import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/screens/sign_in/vm/sign_in_state.dart';
import 'package:todo_app/services/auth_service.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(const SignInState());

  final authService = AuthService();

  Future<void> onClickSignInWithGoogle() async {
    await authService.signInWithGoogle();
  }
}
