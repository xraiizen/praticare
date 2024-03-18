import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/pages/Connexion_Inscription/LoginPage.dart';
import 'package:praticare/pages/Connexion_Inscription/SignInAndUpPage.dart';
import 'package:praticare/pages/Connexion_Inscription/SpashScreen.dart';
import 'package:praticare/pages/Connexion_Inscription/SubmitPage.dart';
import 'package:praticare/pages/Profil/AccountPage.dart';
import 'package:praticare/pages/AllComponentsScreen.dart';
import 'package:praticare/pages/AppointmentPage.dart';
import 'package:praticare/pages/ErrorPage.dart';
import 'package:praticare/pages/HomePage.dart';
import 'package:praticare/pages/Profil/PersonalInformationsPage.dart';
import 'package:praticare/pages/SchoolDetailPage.dart';
import 'package:praticare/pages/SearchMapPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:praticare/theme/theme.dart' as theme;

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    // Ajouter toute logique supplémentaire ici, comme un enregistrement dans un fichier journal
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await intl.initializeDateFormatting('fr_FR', null);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Praticare',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fr', 'FR'),
      theme: ThemeData(
        primaryColor: theme.primary400,
        fontFamily: 'Poppins',
        useMaterial3: true,

        colorScheme: ColorScheme(
            background: theme.grey950,
            onBackground: theme.secondary150,
            brightness: Brightness.light,
            primary: theme.primary400,
            onPrimary: theme.primary400,
            secondary: theme.primary400,
            onSecondary: theme.grey950,
            error: theme.negative400,
            onError: theme.negative400,
            surface: theme.grey950,
            onSurface: theme.grey50),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
        //     .copyWith(error: theme.negative400),
      ),
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const ErrorPage(),
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
          routes: [
            GoRoute(
              path: 'SignInAndUpPage',
              name: 'SignInAndUpPage',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: SignInAndUpPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
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
                child: const SubmitPage(),
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
                child: const HomePage(
                  title: 'Home',
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'SearchMapPage',
              name: 'SearchMapPage',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const SearchMapPage(
                  title: 'Recherche',
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            GoRoute(
              path: 'school/:id',
              pageBuilder: (context, state) {
                final schoolId = state
                    .params['id']!; // Récupère l'ID de l'école depuis l'URL
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SchoolDetailPage(schoolId: schoolId),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                );
              },
            ),
            // GoRoute(
            //   path: 'Favories',
            //   name: 'Favorite',
            //   pageBuilder: (context, state) => CustomTransitionPage<void>(
            //     key: state.pageKey,
            //     child: const FavoritePage(
            //       title: "Favories",
            //     ),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) =>
            //             FadeTransition(opacity: animation, child: child),
            //   ),
            // ),
            GoRoute(
              path: 'Appointment',
              name: 'Appointment',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AppointmentPage(
                  title: "Rendez-vous",
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
                      child: const AccountPage(
                        title: "Compte",
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                routes: [
                  GoRoute(
                    path: "PersonalInformationsPage",
                    name: 'PersonalInformationsPage',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const PersonalInformationsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ]),
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
