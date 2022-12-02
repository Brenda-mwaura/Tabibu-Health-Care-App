import 'package:flutter/material.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/views/auths/auth_base.dart';
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
      title: "Welcome Back",
      subtitle: "Sign in to continue,",
      image: "assets/images/img.svg",
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
              // FormValidator for phone number
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
          ],
        ),
      ),
    );
  }
}
