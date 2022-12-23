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
        fetchProfile();
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
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _profilePictureUpdateSuccessToast();
        await fetchProfile();
        return payload;
      } else {
        _profilePictureUpdateErrorToast(payload);
      }
    }).catchError((error) {
      _profileLoading = false;
      print("error occured while fetching user profile $error");
    });
  }
}

ProfileProvider profileProvider = ProfileProvider();
