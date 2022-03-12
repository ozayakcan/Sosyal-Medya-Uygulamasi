import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/auth.dart';
import '../utils/colors.dart';
import '../utils/variables.dart';
import '../views/login.dart';
import 'widgets.dart';

AuthButtonStyle defaultAuthButtonStyle(double _width) {
  return AuthButtonStyle(
    width: _width,
    height: Variables.defaultButtonHeight,
    borderColor: MyColors.defaultBtnBorderColor,
    splashColor: MyColors.defaultBtnSplashColor,
  );
}

AuthButtonStyle primaryButtonStyle(double _width) {
  return AuthButtonStyle(
    width: _width,
    height: Variables.defaultButtonHeight,
    borderColor: MyColors.defaultBtnBorderColor,
    splashColor: MyColors.defaultBtnSplashColor,
    buttonColor: MyColors.colorPrimary,
    textStyle: const TextStyle(color: Colors.white),
  );
}

AuthButtonStyle secondaryButtonStyle(double _width) {
  return AuthButtonStyle(
    width: _width,
    height: Variables.defaultButtonHeight,
    borderColor: MyColors.defaultBtnBorderColor,
    splashColor: MyColors.defaultBtnSplashColor,
    buttonColor: MyColors.colorSecondary,
    textStyle: const TextStyle(color: Colors.white),
  );
}

GoogleAuthButton googleAuthBtn(BuildContext context) {
  return GoogleAuthButton(
    style: defaultAuthButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      try {
        if (kIsWeb) {
          Auth.signInWithGoogleWeb(context).then((value) {
            if (value != null) {
              ScaffoldSnackbar.of(context).show(value);
            }
          });
        } else {
          Auth.signInWithGoogle(context).then((value) {
            if (value != null) {
              ScaffoldSnackbar.of(context).show(value);
            }
          });
        }
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print(e.message);
        }
      }
    },
    text: AppLocalizations.of(context).login_with_google,
  );
}

EmailAuthButton emailLoginBtn(BuildContext context) {
  return EmailAuthButton(
    style: defaultAuthButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmailLogin()),
      );
    },
    text: AppLocalizations.of(context).login_with_email,
  );
}

CustomAuthButton loginBtn(BuildContext context, TextEditingController email,
    TextEditingController password) {
  return CustomAuthButton(
    iconUrl: "",
    style: primaryButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      Auth.signInWithEmail(context, email.text, password.text).then((value) {
        if (value == null) {
          Navigator.pop(context);
        } else {
          ScaffoldSnackbar.of(context).show(value);
        }
      });
    },
    text: AppLocalizations.of(context).login,
  );
}

CustomAuthButton registerBtn(BuildContext context, TextEditingController email,
    TextEditingController password, TextEditingController passwordRp) {
  return CustomAuthButton(
    iconUrl: "",
    style: secondaryButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      if (password.text == passwordRp.text) {
        Auth.signupWithEmail(context, email.text, password.text).then((value) {
          if (value == null) {
            Auth.sendEmailVerification(context).then((value) {
              if (value == null) {
                if (kDebugMode) {
                  print("Eposta onayı gönderildi.");
                }
              } else {
                if (kDebugMode) {
                  print("Eposta gönderilemedi. Hata: " + value);
                }
              }
            });
            Navigator.pop(context);
          } else {
            ScaffoldSnackbar.of(context).show(value);
          }
        });
      } else {
        ScaffoldSnackbar.of(context)
            .show(AppLocalizations.of(context).passwords_do_not_match);
      }
    },
    text: AppLocalizations.of(context).register,
  );
}

CustomAuthButton resetPasswordBtn(
    BuildContext context, TextEditingController email) {
  return CustomAuthButton(
    iconUrl: "",
    style: secondaryButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      Auth.resetPassword(context, email.text).then((value) {
        if (value == null) {
          ScaffoldSnackbar.of(context)
              .show(AppLocalizations.of(context).reset_password_link_sent);
          email.text = "";
        } else {
          ScaffoldSnackbar.of(context).show(value);
        }
      });
    },
    text: AppLocalizations.of(context).reset_password,
  );
}

CustomAuthButton routeBtn(BuildContext context, Widget widget, String text) {
  return CustomAuthButton(
    iconUrl: "",
    style: secondaryButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    },
    text: text,
  );
}

CustomAuthButton backBtn(BuildContext context, {VoidCallback? action}) {
  return CustomAuthButton(
    iconUrl: "",
    style: defaultAuthButtonStyle(MediaQuery.of(context).size.width),
    onPressed: () {
      if (action == null) {
        Navigator.pop(context);
      } else {
        action();
      }
    },
    text: AppLocalizations.of(context).back,
  );
}
