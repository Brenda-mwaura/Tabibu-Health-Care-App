import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/data/models/clinic_album_model.dart';
import 'package:tabibu/data/models/clinic_doctor_model.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/data/models/clinic_review_model.dart';
import 'package:tabibu/data/models/services.dart';
import 'package:tabibu/data/models/specialization_model.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class ClinicProvider extends ChangeNotifier {
  bool _clinicsLoading = false;
  bool get clinicsLoading => _clinicsLoading;

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

  List<ClinicServices> _clinicServices = [];
  List<ClinicServices> get clinicServices => _clinicServices;

  bool _servicesLoading = false;
  bool get servicesLoading => _servicesLoading;
  Future getClinicServices() async {
    _servicesLoading = true;
    _clinicServices = [];
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicServices().then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var service in payload) {
          _clinicServices.add(ClinicServices.fromJson(service));
        }

        notifyListeners();
        _servicesLoading = false;
        return payload;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await getClinicServices();
      } else {
        _servicesLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching services $error");
    });
  }

  ClinicServices _serviceDetails = ClinicServices();
  ClinicServices get serviceDetails => _serviceDetails;

  Future getClinicServiceDetails(int? serviceID) {
    _servicesLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicServiceDetails(serviceID).then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        _serviceDetails = ClinicServices.fromJson(payload);

        notifyListeners();
        _servicesLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await getClinicServiceDetails(serviceID);
      } else {
        _servicesLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching clinic details $error");
    });
  }

  bool _clinicAlbumLoading = false;
  bool get clinicAlbumLoading => _clinicAlbumLoading;

  List<ClinicAlbum> _clinicAlbum = [];
  List<ClinicAlbum> get clinicAlbum => _clinicAlbum;

  Future getClinicAlbum(int? clinicID) {
    _clinicAlbum = [];
    _clinicAlbumLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicAlbum(clinicID).then((response) async {
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var photo in payload) {
          _clinicAlbum.add(ClinicAlbum.fromJson(photo));
        }
        if (_clinicAlbum.length > 6) {
          _clinicAlbum = _clinicAlbum.sublist(0, 6);
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

  bool _clinicReviewsLoading = false;
  bool get clinicReviewsLoading => _clinicReviewsLoading;

  int _numOfClinicReviews = 0;
  int get numOfClinicReviews => _numOfClinicReviews;

  List<ClinicReview> _clinicReview = [];
  List<ClinicReview> get clinicReview => _clinicReview;

  List<ClinicReview> _allClinicReviews = [];
  List<ClinicReview> get allClinicReviews => _allClinicReviews;

  Future getClinicReviews(int? clinicID) {
    _clinicReviewsLoading = true;
    _clinicReview = [];
    _allClinicReviews = [];
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicReview().then((response) async {
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var review in payload) {
          if (review['clinic'] == clinicID) {
            _allClinicReviews.add(ClinicReview.fromJson(review));
          }
        }
        _numOfClinicReviews = _allClinicReviews.length;

        if (_allClinicReviews.length > 6) {
          _clinicReview = _allClinicReviews.sublist(0, 6);
        }

        notifyListeners();
        _clinicReviewsLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await getClinicReviews(clinicID);
      } else {
        _clinicReviewsLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching clinic reviews $error");
    });
  }

  bool _clinicDoctorsLoading = false;
  bool get clinicDoctorsLoading => _clinicDoctorsLoading;

  List<ClinicDoctor> _clinicDoctors = [];
  List<ClinicDoctor> get clinicDoctors => _clinicDoctors;

  Future getClinicDoctors(int? clinicID) {
    _clinicDoctorsLoading = true;
    _clinicDoctors = [];

    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicDoctors().then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var doctor in payload) {
          if (doctor["clinic"] == clinicID) {
            _clinicDoctors.add(ClinicDoctor.fromJson(doctor));
          }
        }
        notifyListeners();
        _clinicDoctorsLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await getClinicDoctors(clinicID);
      } else {
        _clinicDoctorsLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching clinic doctors $error");
    });
  }

  Specialization _doctorSpecialization = Specialization();
  Specialization get doctorSpecialization => _doctorSpecialization;

  Future getDoctorSpecialization(int? specializationID) async {
    _clinicDoctorsLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.doctorSpecialization(specializationID).then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _doctorSpecialization = Specialization.fromJson(payload);
        notifyListeners();
        _clinicDoctorsLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await getDoctorSpecialization(specializationID);
      } else {
        _clinicDoctorsLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching the doctor specialization $error");
    });
  }

  bool _clinicDetailsLoading = false;
  bool get clinicDetailsLoading => _clinicDetailsLoading;

  Clinic _clinicDetails = Clinic();
  Clinic get clinicDetails => _clinicDetails;

  Future fetchClinicDetails(int? clinicID) async {
    _clinicDetailsLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinicDetails(clinicID).then((response) async {
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _clinicDetails = Clinic.fromJson(payload);
        notifyListeners();
        _clinicDetailsLoading = false;

        return _clinicDetails;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchClinicDetails(clinicID);
      } else {
        _clinicDetailsLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching clinic details $error");
    });
  }

  bool _nearestClinicsLoading = false;
  bool get nearestClinicsLoading => _nearestClinicsLoading;

  Clinic _suggestedClinic = Clinic();
  Clinic get suggestedClinic => _suggestedClinic;

  List<Clinic> _nearestClinics = [];
  List<Clinic> get nearestClinics => _nearestClinics;

  Future fetchNearestClinics(double? lat, double? lng) async {
    _nearestClinicsLoading = true;
    _nearestClinics = [];

    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.clinics().then((response) async {
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var clinic in payload) {
          double clinicLat = clinic["latitude"];
          double clinicLng = clinic["longitude"];

          double distance = await Geolocator.distanceBetween(
              lat!, lng!, clinicLat, clinicLng);

          if (distance <= 10000) {
            _nearestClinics.add(Clinic.fromJson(clinic));
          }
        }

        if (_nearestClinics.length > 0) {
          _suggestedClinic = _nearestClinics[0];
          // fetchTravelTime(
          //     lat, lng, _suggestedClinic.latitude, _suggestedClinic.longitude);
          _nearestClinics.removeAt(0);
        }

        notifyListeners();
        _nearestClinicsLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchNearestClinics(lat, lng);
      } else {
        _nearestClinicsLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching the clinics $error");
    });
  }

  String _travelTime = "15";
  String get travelTime => _travelTime;
  Future fetchTravelTime(double? lat, double? lng, double? suggestedClinicLat,
      double? suggestedClinicLng) {
    return Api.getTravelTime(lat, lng, suggestedClinicLat, suggestedClinicLng)
        .then((response) {
      var payload = jsonDecode(response.body);

      // print("Google Pay load... $payload");
      if (response.statusCode == 200) {
        final timeInSeconds =
            payload['routes'][0]['legs'][0]['duration']['value'];
        _travelTime = timeInSeconds / 60;
        notifyListeners();
        return _travelTime;
      }
    }).catchError((error) {
      print("error occured while fetching travel time $error");
    });
  }
}

ClinicProvider clinicProvider = ClinicProvider();
