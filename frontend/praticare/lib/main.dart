import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/pages/AccountScreen.dart';
import 'package:praticare/pages/AllComponentsScreen.dart';
import 'package:praticare/pages/ErrorScreen.dart';
import 'package:praticare/pages/FavoriteScreen.dart';
import 'package:praticare/pages/HomeScreen.dart';
import 'package:praticare/pages/LoginPage.dart';
import 'package:praticare/pages/SearchPage.dart';
import 'package:praticare/pages/SpashScreen.dart';
import 'package:praticare/pages/SubmitScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:praticare/theme/theme.dart' as theme;

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Praticare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: theme.primary400,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(error: theme.negative400),
      ),
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
          routes: [
            GoRoute(
              path: 'Login',
              name: 'Login',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: LoginPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'Submit',
              name: 'Submit',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const SubmitScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'Home',
              name: 'Home',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(
                  title: 'Home',
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'SearchPage',
              name: 'SearchPage',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const SearchPage(
                  title: 'Recherche',
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'Favories',
              name: 'Favorite',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const FavoriteScreen(
                  title: "Favories",
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'Account',
              name: 'Account',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AccountScreen(
                  title: "Compte",
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'AllComponents',
              name: 'AllComponents',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AllComponentsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
          ])
    ]);
