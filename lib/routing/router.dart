import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/routing/routes.dart';
import 'package:todo_app/screens/home/home_page.dart';
import 'package:todo_app/screens/sign_in/sign_in_page.dart';
import 'package:todo_app/screens/todo_detail/todo_detail_page.dart';

class AppRouter {
  GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: Routes.signIn,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: Routes.signIn,
        builder: (context, state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: Routes.todoDetail,
        pageBuilder: (context, state) {
          TodoEntity? todoEntity = state.extra as TodoEntity?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: TodoDetailPage(
              todoEntity: todoEntity,
            ),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
