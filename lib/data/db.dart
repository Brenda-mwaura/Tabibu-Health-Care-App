import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tabibu/data/models/login_model.dart';
import 'package:tabibu/data/models/password_reset_phone_number_model.dart';
import 'package:tabibu/data/models/password_reset_token_check_model.dart';
import 'package:tabibu/data/models/sign_up_model.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  Box<LoggedInUser>? loginUserDetailsBox;
  Box<SignUp>? signUpAllDetailsBox;
  Box<SignUpUser>? signUpUserDetails;
  Box<PasswordResetPhoneNumber>? passwordResetPhoneNumberAllDetails;
  Box<Data>? passwordResetPhoneNumberDetails;

  Box<TokenCheck>? passwordResetTokenAllDetails;
  Box<OtpData>? passwordResetTokenDetails;

  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox("loginDetailsBox");
    loginUserDetailsBox = await Hive.openBox("loginUserBox");
    signUpAllDetailsBox = await Hive.openBox("signUpDetailsBox");
    signUpUserDetails = await Hive.openBox("signUpUserBox");
    passwordResetPhoneNumberAllDetails =
        await Hive.openBox("passwordresetPhoneNumberAllDetailsBox");
    passwordResetPhoneNumberDetails =
        await Hive.openBox("passwordResetPhoneNumberBox");

    passwordResetTokenDetails =
        await Hive.openBox("passwordResetTokenAllDetailsBox");
    passwordResetTokenDetails =
        await Hive.openBox("passwordResetTokenDetailsBox");
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoggedInUserAdapter());
    Hive.registerAdapter(LoginAdapter());
  }

  _signUpAdapters() async {
    Hive.registerAdapter(SignUpAdapter());
    Hive.registerAdapter(SignUpUserAdapter());
  }

  _passwordResetPhoneNumberAdapters() async {
    Hive.registerAdapter(PasswordResetPhoneNumberAdapter());
    Hive.registerAdapter(DataAdapter());
  }

  _passwordResetTokenCheckAdapters() async {
    Hive.registerAdapter(TokenCheckAdapter());
    Hive.registerAdapter(OtpDataAdapter());
  }

  init() async {
    await Hive.initFlutter();
    await _passwordResetTokenCheckAdapters();
    await _passwordResetPhoneNumberAdapters();
    await _signUpAdapters();
    await _loginAdapters();
    await _initBoxes();
  }
}

DataBase db = DataBase();
// flutter pub run build_runner build --delete-conflicting-outputs
