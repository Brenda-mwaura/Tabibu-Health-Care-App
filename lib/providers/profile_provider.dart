import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tabibu/api/api.dart';
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
}

ProfileProvider profileProvider = ProfileProvider();
