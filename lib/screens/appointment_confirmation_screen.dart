import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthease/models/appointment_model.dart';
import 'package:healthease/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentConfirmationScreen({super.key, required this.appointment});

  Future<void> _saveAppointment(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existingAppointments = prefs.getStringList('appointments') ?? [];

    final String newAppointmentJson = jsonEncode(appointment.toMap());
    existingAppointments.add(newAppointmentJson);

    await prefs.setStringList('appointments', existingAppointments);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Success"),
          content: Text("Appointment saved successfully."),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route)=> route.isFirst);
                },
                child: Text("OK"),
            ),
          ],
        ),
    );
  }

  Widget _infoTile(String label, String value){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Appointment"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoTile("Full Name", appointment.fullName),
            _infoTile("Age", appointment.age.toString()),
            _infoTile("Gender", appointment.gender),
            _infoTile("Speciality", appointment.speciality),
            _infoTile("Date", appointment.appointmentDate),
            _infoTile("Symptoms", appointment.symptoms.isEmpty ? "N/A" : appointment.symptoms),
            Spacer(),
            Center(
              child: ElevatedButton(
                  onPressed: () => _saveAppointment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text("Save Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
