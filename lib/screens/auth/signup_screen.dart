import 'package:flutter/material.dart';
import 'package:isy_shop/config/constants.dart';
import 'package:isy_shop/screens/auth/widgets/social_login_button.dart';
import 'package:isy_shop/screens/home/home_screen.dart';
import 'package:isy_shop/services/user_auth/auth_services.dart';
import 'package:isy_shop/services/user_auth/user.dart';
import 'package:isy_shop/screens/auth/login_screen.dart';
import 'package:isy_shop/screens/auth/routes/signup_arguments.dart';
import 'package:isy_shop/theme/colors.dart';
import 'package:isy_shop/utils/common.dart';
import 'package:isy_shop/utils/helpers/strings.dart';
import 'package:isy_shop/widgets/large_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();
  bool _hidePassword = true;
  bool _enableBtn = false;

  final _auth = AuthServices();

  bool _validatePassword(String password) =>
      password.length >= 6 && containsUpperCaseAndSpecialChar(password);
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

  void _showSnackBar(bool success) {
    final l = getAppLocalizations(context);

    final snackBar = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: success
            ? Theme.of(context).colorScheme.success
            : Theme.of(context).colorScheme.error,
        content: Text(
          success ? l.user_created_successfully : l.error_creating_user,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: success
                  ? Theme.of(context).colorScheme.onSuccess
                  : Theme.of(context).colorScheme.onError),
        )));

    snackBar.closed.then((reason) {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    });
  }

  Future<bool> _signUp() async {
    final loaderOverlay = context.loaderOverlay;
    loaderOverlay.show();

    final createdUser = await _auth.signUpWithEmailAndPassword(
        email: _user.email!, password: _user.password!);

    loaderOverlay.hide();
    return createdUser != null;
  }

  @override
  Widget build(BuildContext context) {
    final l = getAppLocalizations(context);
    bool fromLoginPage = false;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as SignupArguments;
      fromLoginPage = args.fromLoginPage;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              l.create_an_account,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: const Color(0xff112a52)),
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
                        _labelText(l.fullname),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(height: 0, fontSize: 0),
                              hintText: l.enter_fullname,
                              prefixIcon: const Icon(Icons.person_outline)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l.email_empty;
                            }
                            return null;
                          },
                          onSaved: (value) => _user.name = value,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _labelText(l.email),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(height: 0, fontSize: 0),
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
                              errorStyle:
                                  const TextStyle(height: 0, fontSize: 0),
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
                            if (!_validatePassword(value)) {
                              return l.password_invalid;
                            }
                            return null;
                          },
                          onSaved: (value) => _user.password = value,
                        ),
                        const Expanded(child: SizedBox()),
                        LargeButton(
                            text: l.register,
                            disabled: !_enableBtn,
                            onPressed: () {
                              _formKey.currentState!.save();
                              _signUp()
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
                    Text(l.already_have_account),
                    TextButton(
                        onPressed: () {
                          if (fromLoginPage) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          }
                        },
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        child: Text(
                          l.sign_in,
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
