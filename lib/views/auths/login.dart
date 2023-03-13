import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/providers/google_signin_provider.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';
import 'package:tabibu/widgets/spinner.dart';

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

  Future loginSubmit() async {
    if (loginFormKey.currentState!.validate()) {
      await authProvider
          .login(phoneNumberTextEditingController.text,
              passwordTextEditingController.text)
          .then(
        (value) {
          if (value != null) {
            Navigator.of(context).pushNamed(RouteGenerator.homeBasePage);
            phoneNumberTextEditingController.text = "";
            passwordTextEditingController.text = "";
          }
        },
      );
    }
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
              child: Text(
                "Forgot Password?",
                style: Styles.small(context,
                    fontColor: Styles.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AuthButton(
                onPressed: loginSubmit,
                child: Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    if (value.loadingLogin == true) {
                      return const AppSpinner(
                        color: Colors.white,
                      );
                    }
                    return Text(
                      "Sign in",
                      style: Styles.custom25(context,
                          fontColor: Colors.white, fontWeight: FontWeight.w500),
                    );
                  },
                )),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.signUpPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Styles.small(context,
                        fontColor: const Color.fromARGB(255, 154, 154, 154),
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Sign up",
                    style: Styles.custom18(context,
                        fontColor: Styles.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(child: Divider()),
                Text(
                  " OR ",
                  style: Styles.small(
                    context,
                    fontColor: Colors.black,
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Consumer<GoogleSignInProvider>(
                  builder: (context, value, child) {
                return RawMaterialButton(
                  onPressed: () {
                    value.googleLogin();
                  },
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
                      Text("Sign in with Google",
                          style: Styles.custom25(context,
                              fontColor: const Color.fromARGB(255, 72, 72, 72),
                              fontWeight: FontWeight.w700)

                          // TextStyle(
                          //   color: Color.fromARGB(255, 72, 72, 72),
                          //   fontSize: 20,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                );
              }),
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
