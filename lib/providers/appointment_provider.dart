import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/appointment_model.dart';
import 'package:tabibu/providers/auth_provider.dart';

class AppointmentProvider extends ChangeNotifier {
  bool _appointmentBookingLoading = false;
  bool get appointmentBookingLoading => _appointmentBookingLoading;

  set appointmentBookingLoading(bool value) {
    _appointmentBookingLoading = value;
    notifyListeners();
  }

  void _appointmentBookingSuccess() {
    Fluttertoast.showToast(
      msg: "Appointment booked successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _appointmentBookingToastError(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future appointmentBooking(
      int? clinicID,
      String? appointmentDate,
      String? appointmentTime,
      int? serviceID,
      String? paymentPhoneNumber,
      String? yourMessage) async {
    _appointmentBookingLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.appointmentBooking(clinicID, appointmentDate, appointmentTime,
            serviceID, paymentPhoneNumber, yourMessage)
        .then((response) async {
      var payload = json.decode(response.body);
      print("Payload $payload");

      if (response.statusCode == 201) {
        // Appointment appointmentDetails = json.decode(payload);
        notifyListeners();
        _appointmentBookingSuccess();
        _appointmentBookingLoading = false;
        //delay for 2 seconds
        // await Future.delayed(Duration(seconds: 5));
        return payload;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await appointmentBooking(clinicID, appointmentDate, appointmentTime,
            serviceID, paymentPhoneNumber, yourMessage);
      } else {
        _appointmentBookingLoading = false;
        _appointmentBookingToastError(payload.toString());
      }
    }).catchError((error) {
      print("error occured while booking an appointment $error");
    });
  }

  void _lipaNaMpesaSuccessToast() {
    Fluttertoast.showToast(
      msg: "You are being redirected to Mpesa menu",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _lipaNaMpesaErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _payAppointmentLoading = false;
  bool get payAppointmentLoading => _payAppointmentLoading;

  Future lipaAppointmentNaMpesaOnline(
      String? phoneNumber, int? serviceID, int? clinicID) {
    _payAppointmentLoading = true;
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.lipaAppointmentNaMpesaOnline(phoneNumber, serviceID, clinicID)
        .then((response) async {
      var payload = await jsonDecode(response.body);
      if (response.statusCode == 201) {
        _lipaNaMpesaSuccessToast();
        notifyListeners();
        _payAppointmentLoading = false;
        return payload;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await lipaAppointmentNaMpesaOnline(phoneNumber, serviceID, clinicID);
      } else {
        _lipaNaMpesaErrorToast(payload.toString());
        _payAppointmentLoading = false;
      }
    }).catchError((error) {
      print("error occured while booking an appointment $error");
    });
  }

  bool _patientAppointmentLoading = false;
  bool get patientAppointmentLoading => _patientAppointmentLoading;

  List<Appointment> _completedAppointment = [];
  List<Appointment> get completedAppointment => _completedAppointment;

  Future fetchCompletedAppointment() {
    _patientAppointmentLoading = true;
    _completedAppointment = [];
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.patientAppointments().then((response) async {
      var payload = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var appointment in payload) {
          if (appointment["status"] == "Completed") {
            _completedAppointment.add(Appointment.fromJson(appointment));
          }
        }

        notifyListeners();
        _patientAppointmentLoading = false;
        return _completedAppointment;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchCompletedAppointment();
      } else {
        _patientAppointmentLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching completed appointments $error");
    });
  }

  bool _cancelledAppointmentLoading = false;
  bool get cancelledAppointmentLoading => _cancelledAppointmentLoading;

  List<Appointment> _cancelledAppointments = [];
  List<Appointment> get cancelledAppointments => _cancelledAppointments;

  Future fetchCancelledAppointment() {
    _cancelledAppointmentLoading = true;
    _cancelledAppointments = [];
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.patientAppointments().then((response) async {
      var payload = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var appointment in payload) {
          if (appointment["status"] == "Cancelled") {
            _cancelledAppointments.add(Appointment.fromJson(appointment));
          }
        }

        notifyListeners();
        _cancelledAppointmentLoading = false;
        return _cancelledAppointments;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchCancelledAppointment();
      } else {
        _cancelledAppointmentLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching cancelled appointments $error");
    });
  }

  bool _upcomingAppointmentsLoading = false;
  bool get upcomingAppointmentsLoading => _upcomingAppointmentsLoading;

  List<Appointment> _upcomingAppointment = [];
  List<Appointment> get upcomingAppointment => _upcomingAppointment;

  Appointment _nearestUpcomingAppointment = Appointment();
  Appointment get nearestUpcomingAppointment => _nearestUpcomingAppointment;

  Future fetchUpcomingAppointment() {
    _upcomingAppointmentsLoading = true;
    _upcomingAppointment = [];
    _nearestUpcomingAppointment = Appointment();
    String? refreshToken = authProvider.allLoginDetails.refresh;

    return Api.patientAppointments().then((response) async {
      var payload = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var appointment in payload) {
          if (appointment["status"] == "Confirmed" ||
              appointment["status"] == "In Progress" ||
              appointment["status"] == "Pending") {
            //get the first appointment in the payload
            if (_nearestUpcomingAppointment.id == null) {
              _nearestUpcomingAppointment = Appointment.fromJson(appointment);
            } else {
              //get the nearest appointment
              DateTime _nearestAppointmentDate = DateTime.parse(
                  _nearestUpcomingAppointment.appointmentDate.toString());
              DateTime _appointmentDate =
                  DateTime.parse(appointment["appointment_date"]);

              if (_appointmentDate.isBefore(_nearestAppointmentDate)) {
                _nearestUpcomingAppointment = Appointment.fromJson(appointment);
              }
            }
          }
        }
        notifyListeners();
        _upcomingAppointmentsLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await fetchUpcomingAppointment();
      } else {
        _upcomingAppointmentsLoading = false;
      }
    }).catchError((error) {
      print("error occured while fetching upcoming appointments $error");
    });
  }
}

AppointmentProvider appointmentProvider = AppointmentProvider();
