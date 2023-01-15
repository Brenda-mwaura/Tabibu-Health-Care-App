import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/data/models/clinic_album_model.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/auth_provider.dart';

class ClinicProvider extends ChangeNotifier {
  bool _clinicsLoading = false;
  bool get cinicsLoading => _clinicsLoading;

  List<Clinic> _clinics = [];
  List<Clinic> get clinics => _clinics;

  Future fetchClinics() async {
    _clinicsLoading = true;
    _clinics = [];
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinics().then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var clinic in payload) {
          _clinics.add(Clinic.fromJson(clinic));
        }
        print("clinic 1 fetched successfully ${_clinics[0].clinicName}");
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

  bool _clinicAlbumLoading = false;
  bool get clinicAlbumLoading => _clinicAlbumLoading;

  List<ClinicAlbum> _clinicAlbum = [];
  List<ClinicAlbum> get clinicAlbum => _clinicAlbum;

  Future getClinicAlbum(int? clinicID) {
    _clinicAlbumLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicAlbum(clinicID).then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var clinic in payload) {
          _clinics.add(Clinic.fromJson(clinic));
        }

        notifyListeners();
        _clinicAlbumLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await getClinicAlbum(clinicID);
      } else {
        _clinicAlbumLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching the clinic album $error");
    });
  }

  Future fetchNearestClinics(double? lat, double? lng) async {
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinics().then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
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
