import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/db.dart';
import 'package:tabibu/data/models/profile_model.dart';
import 'package:tabibu/providers/auth_provider.dart';

class ProfileProvider extends ChangeNotifier {
  // PatientProfile get allPatientProfileDetails =>
  //     db.patientProfileBox!.getAt(0)!;

  PatientProfile get allPatientProfileDetails =>
      db.patientProfileBox!.values.first;

  bool _profileLoading = false;
  bool get profileLoading => _profileLoading;

  set profileLoading(bool value) {
    _profileLoading = value;
    notifyListeners();
  }

  PatientProfile _profileDetails = PatientProfile();
  PatientProfile get profileDetails => _profileDetails;

  Future fetchProfile() async {
    _profileLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return await Api.profile().then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
        PatientProfile profile = PatientProfile.fromJson(payload[0]);
        _profileDetails = profile;

        db.patientProfileBox!.clear();
        db.patientProfileBox!.add(profile);

        notifyListeners();
        _profileLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchProfile();
      } else {
        _profileLoading = false;
      }
    }).catchError((error) {
      _profileLoading = false;
      print("error occured while fetching user profile $error");
    });
  }

  void _profilePictureUpdateSuccessToast() {
    Fluttertoast.showToast(
      msg: "Profile picture successfully updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _profilePictureUpdateErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future profilePictureUpload(
      String? imagePath, File? profileImage, int? userID) async {
    return await Api.updateProfilePicture(imagePath, profileImage, userID)
        .then((response) async {
      if (response.statusCode == 200) {
        _profilePictureUpdateSuccessToast();
        await fetchProfile();
      } else {
        _profilePictureUpdateErrorToast("Profile upload failed");
      }
    }).catchError((error) {
      _profileLoading = false;
      _profilePictureUpdateErrorToast(error);
      print("error occured while fetching user profile $error");
    });
  }

  void _profileUpdateSuccessToast() {
    Fluttertoast.showToast(
      msg: "Profile updated successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _profileUpdateErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _profileUpdateLoading = false;
  bool get profileUpdateLoading => _profileUpdateLoading;

  set profileUpdateLoading(bool val) {
    _profileUpdateLoading = val;
    notifyListeners();
  }

  PatientProfile _updatedProfileDetails = PatientProfile();
  PatientProfile get updatedProfileDetails => _updatedProfileDetails;

  Future updateProfile(
      {String? phone,
      String? email,
      String? fullName,
      String? bio,
      int? userID}) async {
    _profileUpdateLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return await Api.updateProfile(phone, email, fullName, bio, userID)
        .then((response) async {
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _updatedProfileDetails = PatientProfile.fromJson(payload);
        _profileUpdateSuccessToast();
        _profileUpdateLoading = false;
        return payload;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        updateProfile(
            phone: phone,
            email: email,
            fullName: fullName,
            bio: bio,
            userID: userID);
      } else {
        _profileUpdateErrorToast(payload);
        _profileUpdateLoading = false;
      }
    }).catchError((error) {
      _profileUpdateErrorToast(error);
      _profileLoading = false;
      print("error occured while updating profile $error");
    });
  }
}

ProfileProvider profileProvider = ProfileProvider();
