import 'package:flutter/material.dart';
import 'package:isy_shop/config/constants.dart';
import 'package:isy_shop/screens/auth/forgot_password_screen.dart';
import 'package:isy_shop/screens/auth/routes/signup_arguments.dart';
import 'package:isy_shop/screens/auth/signup_screen.dart';
import 'package:isy_shop/screens/auth/widgets/social_login_button.dart';
import 'package:isy_shop/screens/home/home_screen.dart';
import 'package:isy_shop/services/user_auth/auth_services.dart';
import 'package:isy_shop/services/user_auth/user.dart';
import 'package:isy_shop/theme/colors.dart';
import 'package:isy_shop/utils/common.dart';
import 'package:isy_shop/utils/helpers/strings.dart';
import 'package:isy_shop/widgets/large_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/login';

  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _enableBtn = true;

  final _auth = AuthServices();
  final _user = User();

  bool _validateEmail(String email) => isValidEmail(email);

  Widget _labelText(String text) => Text(
        text,
        style: Theme.of(context).textTheme.labelMedium,
      );

  void _toggleHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  Future<bool> _signin() async {
    final loaderOVerlay = context.loaderOverlay;
    loaderOVerlay.show();

    final user = await _auth.signInWithEmailAndPassword(
        email: _user.email!, password: _user.password!);
    loaderOVerlay.hide();
    return user != null;
  }

  void _showSnackBar(bool success) {
    final l = getAppLocalizations(context);

    final snackBar = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: success
            ? Theme.of(context).colorScheme.success
            : Theme.of(context).colorScheme.error,
        content: Text(
          success ? l.signin_sucessfully : l.signin_with_error,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: success
                  ? Theme.of(context).colorScheme.onSuccess
                  : Theme.of(context).colorScheme.onError),
        )));

    snackBar.closed.then((reason) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = getAppLocalizations(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              l.welcome_back,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Form(
                    key: _formKey,
                    onChanged: () => setState(
                        () => _enableBtn = _formKey.currentState!.validate()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _labelText(l.email),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: l.enter_your_email,
                              prefixIcon: const Icon(Icons.email_outlined)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l.email_empty;
                            }
                            if (!_validateEmail(value)) {
                              return l.email_invalid;
                            }
                            return null;
                          },
                          onSaved: (value) => _user.email = value,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _labelText(l.password),
                        TextFormField(
                          obscureText: _hidePassword,
                          keyboardType: TextInputType.visiblePassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscuringCharacter: AppConfig.obscuringCharacter,
                          decoration: InputDecoration(
                              hintText: l.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: _toggleHidePassword,
                                  icon: Icon(_hidePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l.password_empty;
                            }
                            return null;
                          },
                          onSaved: (value) => _user.password = value,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordScreen.routeName);
                              },
                              child: Text(l.forgot_password)),
                        ),
                        const Expanded(child: SizedBox()),
                        LargeButton(
                            text: l.sign_in,
                            disabled: !_enableBtn,
                            onPressed: () {
                              _formKey.currentState!.save();
                              _signin()
                                  .then((success) => _showSnackBar(success));
                            }),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.center, child: Text(l.or)),
            SizedBox(
              height: 76,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/logos/google.png',
                            width: 34,
                          ))),
                  const SizedBox(
                    width: 34,
                  ),
                  SocialLoginButton(
                    child: IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/images/logos/facebook.png',
                            width: 30)),
                  )
                ],
              ),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l.dont_have_an_account),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              SignupScreen.routeName,
                              arguments:
                                  const SignupArguments(fromLoginPage: true));
                        },
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        child: Text(
                          l.sign_up,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: const Color(0xfff5918a)),
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
