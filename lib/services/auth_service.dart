import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/constants/app_constants.dart';
import 'package:todo_app/enviroment/env.dart';
import 'package:todo_app/models/entity/profile_entity.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<AuthResponse?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: Env.iosClientId,
        serverClientId: Env.webClientId,
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth?.idToken ?? "",
        accessToken: googleAuth?.accessToken,
      );
      return response;
    } on AuthException catch (mess, statusCode) {
      debugPrint("Auth Exception: [$statusCode] - $mess");
      return null;
    } catch (e) {
      debugPrint("Sign in google error: $e");
      return null;
    }
  }

  Future<void> saveToken(ProfileEntity profileEntity) async {
    try {
      await supabase
          .from(AppConstants.profileTable)
          .insert(profileEntity.toJson());
    } catch (e) {
      debugPrint("Save token fcm: $e");
    }
  }
}
