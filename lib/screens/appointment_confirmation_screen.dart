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
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
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
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Appointment Summary",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Divider(height: 30, thickness: 1),
                _infoTile(Icons.person, "Full Name", appointment.fullName),
                _infoTile(Icons.cake, "Age", appointment.age.toString()),
                _infoTile(Icons.wc, "Gender", appointment.gender),
                _infoTile(Icons.medical_services, "Speciality", appointment.speciality),
                _infoTile(Icons.calendar_today, "Date", appointment.appointmentDate),
                _infoTile(Icons.description, "Symptoms", appointment.symptoms.isEmpty ? "N/A" : appointment.symptoms),
                Spacer(),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _saveAppointment(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.save),
                    label: Text(
                      "Save Appointment",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
