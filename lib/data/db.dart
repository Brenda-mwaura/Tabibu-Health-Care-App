import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tabibu/data/models/login_model.dart';
import 'package:tabibu/data/models/password_reset_phone_number_model.dart';
import 'package:tabibu/data/models/otp_check_model.dart';
import 'package:tabibu/data/models/profile_model.dart';
import 'package:tabibu/data/models/sign_up_model.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  Box<LoggedInUser>? loginUserDetailsBox;
  Box<SignUp>? signUpAllDetailsBox;
  Box<SignUpUser>? signUpUserDetails;
  Box<PasswordResetPhoneNumber>? passwordResetPhoneNumberAllDetails;
  Box<Data>? passwordResetPhoneNumberDetails;

  Box<TokenCheck>? otpDetailsBox;
  Box<OtpData>? otpDataDetailsBox;

  Box<PatientProfile>? patientProfileBox;
  Box<User>? userProfileBox;

  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox("loginDetailsBox");
    loginUserDetailsBox = await Hive.openBox("loginUserBox");
    signUpAllDetailsBox = await Hive.openBox("signUpDetailsBox");
    signUpUserDetails = await Hive.openBox("signUpUserBox");
    passwordResetPhoneNumberAllDetails =
        await Hive.openBox("passwordresetPhoneNumberAllDetailsBox");
    passwordResetPhoneNumberDetails =
        await Hive.openBox("passwordResetPhoneNumberBox");

    otpDetailsBox = await Hive.openBox("passwordTokenDetailsBox");
    otpDataDetailsBox = await Hive.openBox("otpDataDetailsBox");

    patientProfileBox = await Hive.openBox("patientProfileDetailsBox");
    userProfileBox = await Hive.openBox("userProfileDetailsBox");
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

  _profileAdapters() async {}

  init() async {
    await Hive.initFlutter();
    _profileAdapters();
    await _passwordResetTokenCheckAdapters();
    await _passwordResetPhoneNumberAdapters();
    await _signUpAdapters();
    await _loginAdapters();
    await _initBoxes();
  }
}

DataBase db = DataBase();
// flutter pub run build_runner build --delete-conflicting-outputs
