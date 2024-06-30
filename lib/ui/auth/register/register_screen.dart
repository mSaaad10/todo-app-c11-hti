import 'package:daily_tasks_app/core/firebase_error_codes.dart';
import 'package:daily_tasks_app/database_manager/model/user.dart' as MyUser;
import 'package:daily_tasks_app/database_manager/user_dao.dart';
import 'package:daily_tasks_app/providers/authentication_provider.dart';
import 'package:daily_tasks_app/ui/auth/login/login_screen.dart';
import 'package:daily_tasks_app/ui/components/custom_text_form-field.dart';
import 'package:daily_tasks_app/utils/dialog_utils.dart';
import 'package:daily_tasks_app/utils/email%20validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController =
      TextEditingController(text: 'Muhamme saad');

  TextEditingController userNameController =
      TextEditingController(text: 'Muhammed saad');

  TextEditingController emailController =
      TextEditingController(text: 'moo@route.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmationPasswordController =
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
          title:
              Text('Register', style: Theme.of(context).textTheme.titleSmall),
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
                  controller: fullNameController,
                  labelText: 'Full Name',
                  keyboardType: TextInputType.text,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter full name';
                    }
                    if (input.length < 8) {
                      return 'Error, full name must be at least 8 chars';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: userNameController,
                  labelText: 'User Name',
                  keyboardType: TextInputType.text,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter user name';
                    }

                    return null;
                  },
                ),
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
                CustomTextFormField(
                  controller: confirmationPasswordController,
                  labelText: 'Password Confirmation',
                  keyboardType: TextInputType.visiblePassword,
                  isObscureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter password Confirmation';
                    }
                    if (input != passwordController.text) {
                      return 'Password not match';
                    }
                    return null;
                  },
                ),
                // CustomButton(
                //   buttonText: 'Sign-Up', onButtonClickedCallBack: signUp,)
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: Text('Sign-Up')),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text("Already have an account? Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    // form validation
    if (!(formKey.currentState!.validate())) {
      return;
    }
    // now u can create user

    try {
      DialogUtils.showLoadingDialog(context, 'Loading...');
     await authProvider.register(emailController.text, passwordController.text, userNameController.text, fullNameController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context,
          'User registered successfully,',
          posActionTitle: 'OK', posAction: () {
        Navigator.pushReplacementNamed(
          context,
          LoginScreen.routeName,
        );
      }, isDismissible: false);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FirebaseErrorCodes.weakPassword) {
        DialogUtils.showMessage(context, 'The password provided is too weak.',
            posActionTitle: 'Try again');
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        DialogUtils.showMessage(
            context, 'The account already exists for that email.',
            posActionTitle: 'Try again');
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, e.toString(),
          posActionTitle: 'Try again');
    }
  }
}
