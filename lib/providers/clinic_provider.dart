import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/auth_provider.dart';

class ClinicProvider extends ChangeNotifier {
  bool _clinicsLoading = false;
  bool get cinicsLoading => _clinicsLoading;

  List<Clinic> _clinics = [];
  List<Clinic> get clinics => _clinics;

  Future fetchClinics() async {
    _clinicsLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinics().then((response) async {
      var payload = jsonDecode(response.body);
      print(payload);
      if (response.statusCode == 200) {
        Clinic clinicDetails = Clinic.fromJson(payload);
        for (var clinic in payload) {
          _clinics.add(Clinic.fromJson(clinic));
        }

        notifyListeners();

        _clinicsLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchClinics();
      } else {
        _clinicsLoading = false;
      }
    }).catchError((error) {
      _clinicsLoading = false;
      print("error occured while fetching the clinics $error");
    });
  }

  Future fetchNearestClinics(double? lat, double? lng) async {
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinics().then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Clinic clinic = Clinic.fromJson(payload);

        print(payload);
        notifyListeners();
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchClinics();
      } else {}
    }).catchError((error) {
      print("error occured while fetching the clinics $error");
    });
  }
}

ClinicProvider clinicProvider = ClinicProvider();
