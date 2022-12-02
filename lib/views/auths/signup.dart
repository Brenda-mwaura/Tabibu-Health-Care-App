import "package:flutter/material.dart";
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  bool _obsecure = true;
  bool _obsecureConfirm = true;
  @override
  Widget build(BuildContext context) {
    return AuthBase(
      title: "Create an Account",
      subtitle: "Sign up to book an appointment,",
      body: Form(
        key: signupFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Email",
              controller: emailTextEditingController,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              prefix: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              validator: (value) => FormValidators().emailValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Phone",
              controller: phoneNumberTextEditingController,
              hintText: "Enter your phone number",
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              prefix: const Icon(Icons.phone, color: Colors.grey),
              validator: (value) => FormValidators().phoneNumberValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Full Name",
              controller: fullnameTextEditingController,
              hintText: "Enter your full name",
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              prefix: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              validator: (value) => FormValidators().fullNameValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Password",
              obsecure: _obsecure,
              controller: passwordTextEditingController,
              hintText: "Enter your password",
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.done,
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              onVisibilityChange: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              validator: (value) => FormValidators().passwordValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Password Confirm",
              controller: confirmPasswordTextEditingController,
              obsecure: _obsecureConfirm,
              hintText: "Enter your password confirmation",
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.done,
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              onVisibilityChange: () {
                setState(() {
                  _obsecureConfirm = !_obsecureConfirm;
                });
              },
              validator: (value) => FormValidators().passwordConfirmValidator(
                  value!, passwordTextEditingController.text),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Flexible(
                      child: Text(
                        "By sign up, you accept to our ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Flexible(
                      // flex: text2.length,
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14,
                            color: Styles.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "and ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 14,
                          color: Styles.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            AuthButton(
              onPressed: () {},
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
