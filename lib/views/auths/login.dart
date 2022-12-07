import 'package:flutter/material.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  //obsecure for password
  bool _obsecure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      showBackIcon: false,
      title: "Welcome Back",
      subtitle: "Sign in to continue,",
      image: "assets/images/login.svg",
      body: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Phone",
              controller: phoneNumberTextEditingController,
              hintText: "Enter your phone number",
              prefix: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              validator: (value) => FormValidators().phoneNumberValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithLabel(
              title: "Password",
              controller: passwordTextEditingController,
              obsecure: _obsecure,
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
              hintText: "Enter your password",
              validator: (value) => FormValidators().passwordValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteGenerator.forgotPasswordPage);
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 14,
                  color: Styles.primaryColor,
                  // Color.fromARGB(255, 20, 106, 218),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AuthButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.homeBasePage);
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.signUpPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color.fromARGB(255, 154, 154, 154),
                    ),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Styles.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: Divider()),
                Text(" OR "),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: Colors.grey.withOpacity(0.3),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusColor: Styles.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/google_signin.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: Color.fromARGB(255, 72, 72, 72),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
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
