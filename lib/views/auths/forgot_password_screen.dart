import 'package:flutter/material.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';

class PasswordResetPhoneScreen extends StatefulWidget {
  PasswordResetPhoneScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetPhoneScreen> createState() =>
      _PasswordResetPhoneScreenState();
}

class _PasswordResetPhoneScreenState extends State<PasswordResetPhoneScreen> {
  GlobalKey<FormState> passwordResetPhoneKey = GlobalKey<FormState>();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();

  Future _passwordResetPhoneNumberFnc() async {
    if (passwordResetPhoneKey.currentState!.validate()) {
      await authProvider
          .passwordResetPhoneNumber(phoneNumberTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed(
            RouteGenerator.forgotPasswordOtpPage,
          );
          phoneNumberTextEditingController.text = "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      showBackIcon: true,
      title: "Forgot Password?",
      subtitle: "Please enter the phone number associated with the account,",
      image: "assets/images/forgot_password.svg",
      body: Form(
        key: passwordResetPhoneKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Phone Number",
              hintText: "Enter your phone number",
              validator: (value) =>
                  FormValidators().phoneNumberValidator(value!),
              controller: phoneNumberTextEditingController,
              keyboardType: TextInputType.text,
              prefix: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthButton(
              onPressed: _passwordResetPhoneNumberFnc,
              child: const Text(
                "Send OTP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
