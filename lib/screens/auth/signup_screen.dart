import 'package:flutter/material.dart';
import 'package:isy_shop/config/constants.dart';
import 'package:isy_shop/screens/auth/login_screen.dart';
import 'package:isy_shop/screens/auth/signup_arguments.dart';
import 'package:isy_shop/utils/common.dart';
import 'package:isy_shop/utils/helpers/strings.dart';
import 'package:isy_shop/widget/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _labelText(l.fullname),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: l.enter_fullname,
                              prefixIcon: const Icon(Icons.person_outline)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l.email_empty;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
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
                            if (!_validatePassword(value)) {
                              return l.password_invalid;
                            }
                            return null;
                          },
                        ),
                        const Expanded(child: SizedBox()),
                        Button(
                            text: l.register, disabled: false, onPressed: () {}),
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
                  _SocialLoginButton(
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/logos/google.png',
                            width: 34,
                          ))),
                  const SizedBox(
                    width: 34,
                  ),
                  _SocialLoginButton(
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

class _SocialLoginButton extends StatelessWidget {
  final Widget child;

  const _SocialLoginButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        child: child);
  }
}
