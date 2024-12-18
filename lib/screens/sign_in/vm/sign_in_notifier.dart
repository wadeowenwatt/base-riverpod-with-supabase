import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/local_db/shared_preference.dart';
import 'package:todo_app/models/entity/profile_entity.dart';
import 'package:todo_app/routing/routes.dart';
import 'package:todo_app/screens/sign_in/vm/sign_in_state.dart';
import 'package:todo_app/services/auth_service.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(const SignInState());

  final authService = AuthService();

  Future<void> onClickSignInWithGoogle(BuildContext context) async {
    final authResponse = await authService.signInWithGoogle();
    if (authResponse != null) {
      await requestNotificationFirebase();
    }
    if (authResponse != null) {
      debugPrint(authResponse.user.toString());
      /// TODO: Save user data.
      if (mounted) {
        context.push(Routes.home);
      }
    }
  }

  Future<void> requestNotificationFirebase() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      return;
    }

    final token = await FirebaseMessaging.instance.getToken();
    final userId = await SharedPreference.getUDID();
    if (userId != null && token != null) {
      await authService.saveToken(ProfileEntity(
        userId: userId,
        fcmToken: token,
      ));
    }
  }
}
