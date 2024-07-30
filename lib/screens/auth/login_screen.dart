import 'package:flutter/material.dart';
import 'package:isy_shop/config/constants.dart';
import 'package:isy_shop/screens/auth/signup_arguments.dart';
import 'package:isy_shop/screens/auth/signup_screen.dart';
import 'package:isy_shop/utils/common.dart';
import 'package:isy_shop/utils/helpers/strings.dart';
import 'package:isy_shop/widget/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;

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
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: Text(l.forgot_password)),
                        ),
                        const Expanded(child: SizedBox()),
                        Button(
                            text: l.sign_in, disabled: false, onPressed: () {}),
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
                    Text(l.already_have_account),
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
