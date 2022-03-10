import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hedef/utils/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(AppLocalizations.of(context).login),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                googleAuthBtn(context),
                const SizedBox(
                  height: 10,
                ),
                emailLoginBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailLogin extends StatelessWidget {
  EmailLogin({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final CustomAuthButton loginBtnVar = loginBtn(
      context,
      emailController,
      passwordController,
    );
    return Scaffold(
      appBar: appBarMain(AppLocalizations.of(context).login_with_email),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                emailTextField(
                  context: context,
                  emailController: emailController,
                  passwordFocus: passwordFocus,
                ),
                const SizedBox(
                  height: 10,
                ),
                passwordTextField(
                  context: context,
                  pwtext: AppLocalizations.of(context).password,
                  passwordController: passwordController,
                  authButton: loginBtnVar,
                  passwordFocus: passwordFocus,
                ),
                const SizedBox(
                  height: 10,
                ),
                loginBtnVar,
                const SizedBox(
                  height: 10,
                ),
                registerRtBtn(context),
                const SizedBox(
                  height: 10,
                ),
                backBtn(context),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailRegister extends StatelessWidget {
  EmailRegister({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRpController = TextEditingController();
  final passwordFocus = FocusNode();
  final passwordRpFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final CustomAuthButton registerBtnVar = registerBtn(
      context,
      emailController,
      passwordController,
      passwordRpController,
    );
    return Scaffold(
      appBar: appBarMain(AppLocalizations.of(context).login_with_email),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                emailTextField(
                  context: context,
                  emailController: emailController,
                  passwordFocus: passwordFocus,
                ),
                const SizedBox(
                  height: 10,
                ),
                passwordTextField(
                  context: context,
                  pwtext: AppLocalizations.of(context).password,
                  passwordController: passwordController,
                  passwordFocus: passwordFocus,
                  passwordRpFocus: passwordRpFocus,
                ),
                passwordTextField(
                  context: context,
                  pwtext: AppLocalizations.of(context).password_repeat,
                  passwordController: passwordRpController,
                  authButton: registerBtnVar,
                  passwordFocus: passwordRpFocus,
                ),
                const SizedBox(
                  height: 10,
                ),
                registerBtnVar,
                const SizedBox(
                  height: 10,
                ),
                backBtn(context, action: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EmailLogin()),
                  );
                }),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}