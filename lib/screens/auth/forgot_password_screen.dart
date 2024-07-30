import 'package:flutter/material.dart';
import 'package:isy_shop/utils/common.dart';
import 'package:isy_shop/utils/helpers/strings.dart';
import 'package:isy_shop/widget/large_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _disabled = true;

  void _onSubmit() {
    // final email = _emailController.text.toLowerCase().trim();
  }

  void _checkDisabled() {
    final email = _emailController.text.toLowerCase().trim();
    setState(() {
      _disabled = email.isEmpty || !isValidEmail(email);
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkDisabled);
  }

  @override
  Widget build(BuildContext context) {
    final l = getAppLocalizations(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.forgot_password,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: const Color(0xff112a52),
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                l.forgot_password_text,
                softWrap: true,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.75)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: l.enter_your_email,
                    prefixIcon: const Icon(Icons.email_outlined)),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: LargeButton(
                    text: l.continue_btn,
                    disabled: _disabled,
                    onPressed: _onSubmit),
              )),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.removeListener(_checkDisabled);
    _emailController.dispose();
  }
}
