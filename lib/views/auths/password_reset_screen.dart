import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';
import 'package:tabibu/widgets/spinner.dart';

class PasswordResetScreen extends StatefulWidget {
  PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  GlobalKey<FormState> passwordResetFormKey = GlobalKey<FormState>();
  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  bool _obsecure = true;
  bool _obsecureConfirm = true;

  Future _passwordResetFnc() async {
    if (passwordResetFormKey.currentState!.validate()) {
      await authProvider
          .passwordReset(passwordTextEditingController.text,
              confirmPasswordTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(context).popAndPushNamed(RouteGenerator.loginPage);
          passwordTextEditingController.text = "";
          confirmPasswordTextEditingController.text = "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      showBackIcon: true,
      title: "Create new password",
      subtitle: "Enter your new password",
      image: "assets/images/password_reset.svg",
      body: Form(
        key: passwordResetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Password",
              hintText: "Enter Password",
              obsecure: _obsecure,
              controller: passwordTextEditingController,
              validator: (value) => FormValidators().passwordValidator(value!),
              inputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              onVisibilityChange: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithLabel(
              title: "Password Confirm",
              hintText: "Enter Password Confirmation",
              obsecure: _obsecureConfirm,
              controller: confirmPasswordTextEditingController,
              validator: (value) => FormValidators().passwordConfirmValidator(
                  value!, passwordTextEditingController.text),
              inputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              onVisibilityChange: () {
                setState(() {
                  _obsecureConfirm = !_obsecureConfirm;
                });
              },
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthButton(
              onPressed: _passwordResetFnc,
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.passwordResetLoading == true) {
                    return const AppSpinner(
                      color: Colors.white,
                    );
                  }
                  return const Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
