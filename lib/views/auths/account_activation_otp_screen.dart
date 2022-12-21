import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/views/auths/auth_base.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/otp_input.dart';
import 'package:tabibu/widgets/spinner.dart';

class ActivationOTPScreen extends StatefulWidget {
  ActivationOTPScreen({Key? key}) : super(key: key);

  @override
  State<ActivationOTPScreen> createState() => _ActivationOTPScreenState();
}

class _ActivationOTPScreenState extends State<ActivationOTPScreen> {
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  TextEditingController _pin1TextEditingController = TextEditingController();
  TextEditingController _pin2TextEditingController = TextEditingController();
  TextEditingController _pin3TextEditingController = TextEditingController();
  TextEditingController _pin4TextEditingController = TextEditingController();
  TextEditingController _pin5TextEditingController = TextEditingController();
  TextEditingController _pin6TextEditingController = TextEditingController();

  Future activationOtpFnc() async {
    if (otpFormKey.currentState!.validate()) {
      var otp = _pin1TextEditingController.text +
          _pin2TextEditingController.text +
          _pin3TextEditingController.text +
          _pin4TextEditingController.text +
          _pin5TextEditingController.text +
          _pin6TextEditingController.text;
      if (otp.length == 6) {
        await authProvider.otp(otp).then((value) {
          if (value != null) {
            Navigator.of(context).pushNamed(RouteGenerator.loginPage);
            _pin1TextEditingController.text = "";
            _pin2TextEditingController.text = "";
            _pin3TextEditingController.text = "";
            _pin4TextEditingController.text = "";
            _pin5TextEditingController.text = "";
            _pin6TextEditingController.text = "";
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Invalid OTP"),
                backgroundColor: Styles.primaryColor,
              ),
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      showBackIcon: true,
      title: "Enter OTP",
      subtitle: "Enter the OTP sent to your phone,",
      image: "assets/images/otp.svg",
      body: Form(
        key: otpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpInputBox(
                  controller: _pin1TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin2TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin3TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin4TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin5TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin6TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            AuthButton(
              onPressed: activationOtpFnc,
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.otpLoading == true) {
                    return AppSpinner();
                  }
                  return const Text(
                    "Verify OTP",
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
