import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:isy_shop/config/constants.dart';
import 'package:isy_shop/config/remote_config.dart';
import 'package:isy_shop/screens/auth/forgot_password_screen.dart';
import 'package:isy_shop/screens/auth/signin_screen.dart';
import 'package:isy_shop/screens/auth/signup_screen.dart';
import 'package:isy_shop/screens/home/home_screen.dart';
import 'package:isy_shop/services/user_auth/auth_services.dart';
import 'package:isy_shop/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'firebase_options.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfig.init();
  runApp(App());
}

class App extends StatelessWidget {
  final _auth = AuthServices();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final initialRoute =
        _auth.isLoggedIn ? HomeScreen.routeName : SigninScreen.routeName;

    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.25),
      overlayWidgetBuilder: (_) => Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.black.withOpacity(0.5),
          size: 50.0,
        ),
      ),
      child: MaterialApp(
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
        initialRoute: initialRoute,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SigninScreen.routeName: (context) => const SigninScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen()
        },
      ),
    );
  }
}
