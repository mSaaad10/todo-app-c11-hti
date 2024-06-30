import 'package:daily_tasks_app/core/firebase_error_codes.dart';
import 'package:daily_tasks_app/database_manager/user_dao.dart';
import 'package:daily_tasks_app/providers/authentication_provider.dart';
import 'package:daily_tasks_app/ui/auth/register/register_screen.dart';
import 'package:daily_tasks_app/ui/components/custom_button.dart';
import 'package:daily_tasks_app/ui/components/custom_text_form-field.dart';
import 'package:daily_tasks_app/ui/home/home_screen.dart';
import 'package:daily_tasks_app/utils/dialog_utils.dart';
import 'package:daily_tasks_app/utils/email%20validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'moo@route.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/auth_background.png'))),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login', style: Theme.of(context).textTheme.titleSmall),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter e-mail address';
                    }
                    if (!isValidEmail(input)) {
                      return 'E-mail bad format';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  isObscureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter password';
                    }
                    if (input.length < 6) {
                      return 'Password must be at least 6 chars';
                    }

                    return null;
                  },
                ),
                CustomButton(
                  buttonText: 'Sign-In',
                  onButtonClickedCallBack: signIn,
                ),

                TextButton(onPressed: () {
                  Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                }, child: Text("Don't have an account? Create Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    // form validation
    if (!(formKey.currentState!.validate())) {
      return;
    }
    try {
      DialogUtils.showLoadingDialog(
        context,
        'Loading...',
      );
     await authProvider.login(emailController.text, passwordController.text);

      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context, 'User Logged in Successfully ',
          posActionTitle: 'Yes', negActionTitle: 'Cancel', posAction: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },

      );
      // print(result.user?.uid);
      //Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FirebaseErrorCodes.userNotFound ||
          e.code == FirebaseErrorCodes.wrongPassword) {
        DialogUtils.showMessage(context, 'error email or password', posActionTitle: 'Try again',);
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, e.toString());
    }
  }
}
