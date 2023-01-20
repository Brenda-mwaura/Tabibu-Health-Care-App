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
      gravity: ToastGravity.BOTTOM,
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
        Appointment appointmentDetails = json.decode(payload);
        notifyListeners();
        _appointmentBookingSuccess();
        _appointmentBookingLoading = false;
      } else if (response.statusCode == 401) {
        await authProvider.refreshToken(refreshToken);
        await appointmentBooking(clinicID, appointmentDate, appointmentTime,
            serviceID, paymentPhoneNumber, yourMessage);
      } else {
        _appointmentBookingLoading = false;
        _appointmentBookingToastError(payload);
      }
    }).catchError((error) {
      print("error occured while booking an appointment $error");
    });
  }
}

AppointmentProvider appointmentProvider = AppointmentProvider();
