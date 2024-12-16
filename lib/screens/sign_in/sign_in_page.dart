import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/screens/sign_in/vm/sign_in_notifier.dart';
import 'package:todo_app/screens/sign_in/vm/sign_in_state.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late StateNotifierProvider<SignInNotifier, SignInState> signInProvider;
  late SignInNotifier vmRead;

  @override
  void initState() {
    super.initState();
    signInProvider = StateNotifierProvider((ref) => SignInNotifier());
    vmRead = ref.read(signInProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              vmRead.onClickSignInWithGoogle();
            },
            child: const Text("login"),
          ),
        ),
      ),
    );
  }
}
