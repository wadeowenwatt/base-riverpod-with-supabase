import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/enviroment/env.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
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
    } catch (e) {
      print("sign in google error: $e");
    }
  }
}
