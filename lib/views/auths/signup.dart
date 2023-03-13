import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';
import 'package:tabibu/widgets/spinner.dart';

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

  Future registerSubmitFnc() async {
    if (signupFormKey.currentState!.validate()) {
      await authProvider
          .signUp(
              phoneNumberTextEditingController.text,
              emailTextEditingController.text,
              fullnameTextEditingController.text,
              passwordTextEditingController.text,
              confirmPasswordTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed(RouteGenerator.activationOtpPage);
          phoneNumberTextEditingController.text = "";
          emailTextEditingController.text = "";
          fullnameTextEditingController.text = "";
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
      title: "Create an Account",
      subtitle: "Sign up to book an appointment,",
      image: "assets/images/signup.svg",
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
                    Flexible(
                      child: Text(
                        "By sign up, you accept to our ",
                        style: Styles.small(context,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Flexible(
                      // flex: text2.length,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Terms & Conditions",
                          style: Styles.small(context,
                              fontColor: Styles.primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "and ",
                      style: Styles.small(context,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Privacy Policy",
                        style: Styles.small(context,
                            fontColor: Styles.primaryColor,
                            fontWeight: FontWeight.w700),
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
                onPressed: registerSubmitFnc,
                child: Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    if (value.loadingSignUp == true) {
                      return const AppSpinner(
                        color: Colors.white,
                      );
                    } else {
                      return Text(
                        "Sign up",
                        style: Styles.custom25(context,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.w500),
                      );
                    }
                  },
                )),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.loginPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: Styles.small(context,
                        fontColor: const Color.fromARGB(255, 154, 154, 154),
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Login",
                    style: Styles.custom18(context,
                        fontColor: Styles.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
