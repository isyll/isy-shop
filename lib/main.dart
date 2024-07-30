import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:isy_shop/config/constants.dart';
import 'package:isy_shop/config/remote_config.dart';
import 'package:isy_shop/screens/auth/forgot_password_screen.dart';
import 'package:isy_shop/screens/auth/login_screen.dart';
import 'package:isy_shop/screens/auth/signup_screen.dart';
import 'package:isy_shop/screens/home/home_screen.dart';
import 'package:isy_shop/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfig.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: AppConfig.defaultLocale,
      supportedLocales: AppConfig.supportedLocales,
      //   home: const AuthenticationGate(),
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen()
      },
    );
  }
}

class AuthenticationGate extends StatefulWidget {
  const AuthenticationGate({super.key});

  @override
  State<AuthenticationGate> createState() => _AuthenticationGateState();
}

class _AuthenticationGateState extends State<AuthenticationGate> {
  bool _isAuthenticated = false;
  bool _isLoading = true;

  Future<void> _checkAuthentication() async {
    _isLoading = true;
    setState(() {
      _isAuthenticated = false;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isAuthenticated) {
      return const LoginScreen();
    }
    return const HomeScreen();
  }
}
